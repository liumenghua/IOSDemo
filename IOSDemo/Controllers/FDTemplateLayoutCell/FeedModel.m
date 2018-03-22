//
//  FeedModel.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/22.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _identifier = [self getUniqueIdentifier];
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _username = dictionary[@"username"];
        _time = dictionary[@"time"];
        _imageName = dictionary[@"imageName"];
    }
    return self;
}

- (NSString *)getUniqueIdentifier{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter + 1)];
}
@end
