//
//  AppearanceViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/12.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "AppearanceViewController.h"
#import "UITableView+Appearance.h"

@interface AppearanceViewController ()

@end

@implementation AppearanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 这个这样设置不行 可能是官网上说的note的原因
    [[UITableView appearance] setseparatorLineHidden:YES];
    
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 80)];
//    [btn setTitle:@"去掉分割线，全局" forState:UIControlStateNormal];
////    [btn setTitle:@"恢复分割线 全局" forState:UIControlStateSelected];
//    btn.backgroundColor = [UIColor lightGrayColor];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn
{

}



@end
