//
//  MyTimer.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/26.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "MyTimer.h"

@interface MyTimer()
@property (nonatomic, strong) NSTimer * timer;
@end
@implementation MyTimer
- (instancetype)init{
    self = [super init];
    if (self) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRefresh:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timeRefresh:(NSTimer *)timer{
    NSLog(@"TimeRefresh...");
}

- (void)cleanTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc{
     NSLog(@"销毁");
    [self cleanTimer];
}
@end
