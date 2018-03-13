//
//  MasonryDistributeView.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/13.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "MasonryDistributeView.h"
#import <Masonry.h>

@implementation MasonryDistributeView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI1];
        [self setupUI2];
    }
    return self;
}

- (void)setupUI1
{
    UIView * blueView = [self createView:[UIColor blueColor] borderWith:2.f borderColor:[UIColor blackColor]];
    [self addSubview: blueView];
    
    UIView * redView = [self createView:[UIColor redColor] borderWith:2.f borderColor:[UIColor blackColor]];
    [self addSubview: redView];
    
    UIView * purpleView = [self createView:[UIColor purpleColor] borderWith:2.f borderColor:[UIColor blackColor]];
    [self addSubview: purpleView];
    
    UIView * greenView = [self createView:[UIColor greenColor] borderWith:2.f borderColor:[UIColor blackColor]];
    [self addSubview: greenView];
    
    [@[blueView, redView, purpleView, greenView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(100);
        make.height.mas_equalTo(60);
    }];
    
    // 根据间隙计算大小
    [@[blueView, redView, purpleView, greenView] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
    
}

- (void)setupUI2
{
    UIView * blueView = [self createView:[UIColor blueColor] borderWith:2.f borderColor:[UIColor blackColor]];
    [self addSubview: blueView];
    
    UIView * redView = [self createView:[UIColor redColor] borderWith:2.f borderColor:[UIColor blackColor]];
    [self addSubview: redView];
    
    UIView * purpleView = [self createView:[UIColor purpleColor] borderWith:2.f borderColor:[UIColor blackColor]];
    [self addSubview: purpleView];
    
    UIView * greenView = [self createView:[UIColor greenColor] borderWith:2.f borderColor:[UIColor blackColor]];
    [self addSubview: greenView];
    
    [@[blueView, redView, purpleView, greenView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(200);
        make.height.mas_equalTo(60);
    }];
    
    // 根据大小计算间隙
    [@[blueView, redView, purpleView, greenView] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:90 leadSpacing:5 tailSpacing:5];
    
}

- (UIView *)createView:(UIColor *)color borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor
{
    UIView * customView = [[UIView alloc]initWithFrame:CGRectZero];
    customView.backgroundColor = color;
    customView.layer.borderWidth = borderWith;
    customView.layer.borderColor = borderColor.CGColor;
    
    return customView;
}

@end
