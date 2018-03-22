//
//  FeedModel.h
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/22.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedModel : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic, copy, readonly) NSString *identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
