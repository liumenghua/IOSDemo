//
//  Masonry.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/12.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "MasonryBasicView.h"
#import <Masonry.h>

@implementation MasonryBasicView

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
    UIView * greenView = [[UIView alloc]init];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.layer.borderColor = [UIColor blackColor].CGColor;
    greenView.layer.borderWidth = 2.f;
    [self addSubview:greenView];
    
    UIView * redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    redView.layer.borderColor = [UIColor blackColor].CGColor;
    redView.layer.borderWidth = 2.f;
    [self addSubview:redView];
    
    UIView * blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.layer.borderColor = [UIColor blackColor].CGColor;
    blueView.layer.borderWidth = 2.f;
    [self addSubview:blueView];
    
    CGFloat lineSpace = 10.f;

    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(lineSpace);
        make.right.mas_equalTo(redView.mas_left).mas_offset(-lineSpace);
        make.bottom.mas_equalTo(blueView.mas_top).mas_offset(-lineSpace);
        make.height.width.mas_equalTo(redView);
        make.height.mas_equalTo(@[redView, blueView]);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-lineSpace);
        make.left.mas_equalTo(greenView.mas_right).mas_offset(-lineSpace);
        make.bottom.top.mas_equalTo(greenView.mas_bottom);
        make.height.width.mas_equalTo(greenView);
        make.height.mas_equalTo(blueView);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(lineSpace);
        make.bottom.right.mas_equalTo(self).mas_offset(-lineSpace);
        make.top.mas_equalTo(greenView.mas_bottom).mas_offset(lineSpace);
    }];
    
    
    
}

@end
