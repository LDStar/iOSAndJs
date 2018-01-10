//
//  ViewController.m
//  webView
//
//  Created by 刘东 on 2018/1/9.
//  Copyright © 2018年 刘东. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,WKScriptMessageHandler>

@property (nonatomic, strong)  WKWebView* wb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWB];
    [self createBtn];
    
}

-(void)createWB{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    CGRect wbFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100);
    _wb = [[WKWebView alloc] initWithFrame:wbFrame configuration:config];
    _wb.navigationDelegate = self;
    _wb.UIDelegate = self;
    _wb.scrollView.bounces = NO;
    
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"try1" ofType:@"html"]];
    
    if (@available(iOS 9.0, *)) {
        [_wb loadFileURL:url allowingReadAccessToURL:url];
    } else {
        
    }
    //    NSString * url = @"https://www.baidu.com";
    //    NSString * url = @"http://xzqyun.com/aaa/9/";
    //    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //    [_wb loadRequest:request];
    
    [self.view addSubview:_wb];
}
-(void)createBtn{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame =CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100);
    [btn setTitle:@"我是一个原生按钮" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick{
    /**
     iOS调用JS方法
     iOSToJs()这个是JS中方法的名称
     具体怎么定义双方去协调
     */
    
    [_wb evaluateJavaScript:@"iOSToJs()" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        //obj是JS return回来的值
    }];
}

//JS调用iOS的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    /**
     如果webview想要做到复用
     可能不同的页面调用iOS不同的功能
     这是可以和H5协商一种策略
     例如：返回一个type，如果type是什么iOS做什么样的操作
     至于怎么去定义，双方协商
     */
    NSLog(@"%@",message.body[@"type"]);
    NSString * type = message.body[@"type"];
    if ([type isEqualToString:@"1"]) {
        NSLog(@"我做type是1的操作");
    }else if ([type isEqualToString:@"2"]){
        NSLog(@"我做type是2的操作");
    }
    
    
    
}
/**
 wk里面不会直接弹出js中的alert，实现这个代理方法自己去谈alert
 这里只是想更明显的证明iOS调用JS成功了
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


@end
