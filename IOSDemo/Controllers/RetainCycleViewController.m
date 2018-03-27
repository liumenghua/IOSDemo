
//
//  RetainCycleViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/26.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "RetainCycleViewController.h"
#import "MyTimer.h"

@interface RetainCycleViewController ()


@end

@implementation RetainCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyTimer * timer = [[MyTimer alloc]init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSTimr


@end
