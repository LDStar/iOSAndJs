//
//  ViewController.h
//  webView
//
//  Created by 刘东 on 2018/1/9.
//  Copyright © 2018年 刘东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface ViewController : UIViewController


@end

//添加这个代理的目的是避免webview返回后不释放
@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

