//
//  RootController.m
//  webView
//
//  Created by 刘东 on 2018/1/12.
//  Copyright © 2018年 刘东. All rights reserved.
//

#import "RootController.h"
#import "ViewController.h"
@interface RootController ()

@end

@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)click:(id)sender {
    
    ViewController * vc = [[ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
