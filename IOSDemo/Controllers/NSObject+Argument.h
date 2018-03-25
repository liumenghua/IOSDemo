//
//  NSObject+Argument.h
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/24.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Argument)

- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
@end
