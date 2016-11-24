//
//  ViewController.m
//  ZKLogDemo
//
//  Created by liuzikang on 16/11/22.
//  Copyright © 2016年 MyProject. All rights reserved.
//

#import "ViewController.h"
#import "UIView+layer.h"
#import "ZKLog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [button setCenter:self.view.center];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button setTitle:@"create logs" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setCornerRadius:8 borderWidth:1 borderColor:button.currentTitleColor];
    [button addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGRect frame = CGRectMake(button.frame.origin.x,
                              button.frame.origin.y+30+10,
                              100, 30);
    UIButton *button1 = [[UIButton alloc]initWithFrame:frame];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button1 setTitle:@"show logs" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setCornerRadius:8 borderWidth:1 borderColor:button.currentTitleColor];
    [button1 addTarget:self action:@selector(onClickBtn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

#pragma mark - ClickEvent
- (void)onClickBtn:(UIButton*)button
{
    button.tag += 1;
    [ZKLog log:@"%@-%ld", @"logTest", button.tag];
}

- (void)onClickBtn1:(UIButton*)button
{
    !button.selected ? [ZKLog show] : [ZKLog hide];
    button.selected = !button.selected;
}

@end
