//
//  AppearanceView.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/12.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "AppearanceView.h"

@implementation AppearanceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];  // 不知道为什么这个不行！！bug
        
        UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        greenView.backgroundColor = UIColor.greenColor;
        greenView.layer.borderColor = UIColor.blackColor.CGColor;
        greenView.layer.borderWidth = 2;
        [self addSubview:greenView];
    }
    return self;
}

@end
