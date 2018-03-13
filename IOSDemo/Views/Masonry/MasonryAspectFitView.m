//
//  MasonryAspectFitView.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/13.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "MasonryAspectFitView.h"
#import <Masonry.h>

@implementation MasonryAspectFitView


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
    UIView * topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = [UIColor colorWithRed:0.663 green:0.796 blue:0.996 alpha:1];
    [self addSubview:topView];
    
    UIView * topInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    topInnerView.backgroundColor = [UIColor colorWithRed:0.784 green:0.992 blue:0.852 alpha:1];
    [self addSubview:topInnerView];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor colorWithRed:0.992 green:0.804 blue:0.941 alpha:1];
    [self addSubview:bottomView];
    
    UIView * bottomInnerView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomInnerView.backgroundColor = [UIColor colorWithRed:0.443 green:0.780 blue:0.337 alpha:1];
    [self addSubview:bottomInnerView];
    
    // Constraints
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(bottomView.mas_top);
        make.height.mas_equalTo(bottomView);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
    
    [topInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(topView);
        make.height.mas_equalTo(topView).multipliedBy(0.33);
        make.center.mas_equalTo(topView);
    }];
    
    [bottomInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bottomView);
        make.width.mas_equalTo(bottomView).multipliedBy(0.33);
        make.center.mas_equalTo(bottomView);
    }];
    
}
@end
