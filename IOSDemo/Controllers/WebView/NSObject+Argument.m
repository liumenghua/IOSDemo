//
//  NSObject+Argument.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/24.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "NSObject+Argument.h"

@implementation NSObject (Argument)
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects{
    
    // 方法签名 - 对方法的描述
    NSMethodSignature * signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil){
        // 抛出异常
        @throw [NSException exceptionWithName:@"NSMethodSignature error" reason:@"NSMethodSignature is null" userInfo:nil];
    }
    
    //利用 NSInvocation 对象包装一次方法调用（方法调用者、方法名、方法参数、犯法返回值）
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self; // 调用者
    invocation.selector = selector; // 调用的方法
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除掉self和_cmd以外的参数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object= objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i+2];
    }
    
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    id returnVlue = nil;
    if (signature.methodReturnLength) { // 有返回值类型
        [invocation getReturnValue:&returnVlue];// 如果没有返回值 而去获取返回值就会出问题
    }
    
    return returnVlue;
}
@end
