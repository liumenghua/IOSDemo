//
//  MasonryRemakeView.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/13.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "MasonryRemakeView.h"
#import <Masonry.h>

#define space 10

@interface MasonryRemakeView()
@property (nonatomic, strong) UIButton * movingButton;
@property (nonatomic, assign) BOOL isTopLeft;

@end

@implementation MasonryRemakeView

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
    _movingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_movingButton setTitle:@"Moving Me!" forState:UIControlStateNormal];
    _movingButton.layer.borderColor = [[UIColor greenColor] CGColor];
    _movingButton.layer.borderWidth = 2.f;
    [_movingButton addTarget:self action:@selector(movingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_movingButton];
    
    _isTopLeft = YES;
}

// 保证系统一定会调用updateConstraints方法
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

// 这是苹果推荐的做法
- (void)updateConstraints
{
    [_movingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(@100);
        
        if (_isTopLeft) {
            make.top.left.mas_equalTo(self).mas_offset(space);
        }else{
            make.bottom.right.mas_equalTo(self).mas_offset(-space);
        }
        
    }];
    
    [super updateConstraints];
}

- (void)movingButtonClick:(UIButton *)button
{
    _isTopLeft = !_isTopLeft;
    
    // tell constraints they need updating  会走updateConstraints方法
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
