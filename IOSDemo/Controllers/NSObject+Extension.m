//
//  NSObject+Extension.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/27.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)name{
    return objc_getAssociatedObject(self, _cmd);
}

@end
