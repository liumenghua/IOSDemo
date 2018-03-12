//
//  UIViewController+Extension.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/12.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}
@end
