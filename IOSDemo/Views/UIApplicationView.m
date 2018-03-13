//
//  UIApplicationVIew.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/13.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "UIApplicationView.h"
#import <Masonry.h>

@interface UIApplicationView()
@property (nonatomic, strong) UITextField * badgeTextField;
@end

@implementation UIApplicationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UILabel * label = [[UILabel alloc]init];
    label.layer.borderColor = [[UIColor greenColor] CGColor];
    label.layer.borderWidth = 2.f;
    label.text = @"代码在 AppDelegate.m";
    [label sizeToFit];
    [self addSubview: label];
    
    //
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(20);
        make.centerX.mas_equalTo(self);
    }];

    UILabel * badgeLabel = [[UILabel alloc]init];
    badgeLabel.text = @"设置badge数量,确定home返回能看到程序图标右上角数字变化效果:";
    [badgeLabel sizeToFit];
    badgeLabel.numberOfLines = 0;
    [self addSubview: badgeLabel];
    
    [badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(30);
        make.right.mas_equalTo(self).offset(-30);
    }];
    
    UITextField * badgeTextField = [[UITextField alloc]init];
    badgeTextField.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:badgeTextField];
    self.badgeTextField = badgeTextField;
    
    [badgeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(badgeLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self);
        make.left.right.mas_equalTo(badgeLabel);
    }];
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.layer.borderColor = [[UIColor greenColor] CGColor];
    sureButton.layer.borderWidth = 2.f;
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureButton];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(badgeTextField.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self);
        make.left.right.mas_equalTo(badgeLabel);
    }];
    
    UIButton * clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [clearButton setTitle:@"清除右上角数字" forState:UIControlStateNormal];
    clearButton.layer.borderColor = [[UIColor greenColor] CGColor];
    clearButton.layer.borderWidth = 2.f;
    [clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clearButton];
    
    [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sureButton.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self);
        make.left.right.mas_equalTo(badgeLabel);
    }];
    
}

- (void)sureButtonClick:(UIButton *)button
{
    if (self.badgeTextField.text.length == 0) {
        return ;
    }
    
    NSUInteger num = (NSUInteger)self.badgeTextField.text.integerValue;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:num];
}

- (void)clearButtonClick:(UIButton *)button
{
    //清空通知中心
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
}

@end
