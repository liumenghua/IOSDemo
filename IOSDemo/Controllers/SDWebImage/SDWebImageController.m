//
//  SDWebImageController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/25.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "SDWebImageController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SDWebImageController ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSURLConnection * connection;
@end

@implementation SDWebImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"沙盒路径:%@", NSHomeDirectory());
    
    // 1. 获取Documents路径
    NSString * doucmentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"doucmentPath = %@", doucmentPath);
    
    // 2. 获取Library路径
    NSString * libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)firstObject];
    NSLog(@"libraryPath = %@", libraryPath);
    
    // 3. 获取tmp路径
    NSString * tmpPath = NSTemporaryDirectory();
    NSLog(@"tmpPath = %@", tmpPath);
    
    // 4. 获取Cache路径
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"cachePath = %@", cachePath);
    
    // 5. 获取Preferences路径
    NSString * preferences = [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"preferences = %@", preferences);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)downloadClick:(id)sender {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/6c224f4a20a446230761b9b79c22720e0df3d7bf.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"download error = %@", error);
        }else{
            NSLog(@"下载成功");
            NSLog(@"imageURL = %@", imageURL);
        }
    }];
}

- (IBAction)deleteClcik:(id)sender {
    if (self.imageView.image) {
        self.imageView.image = nil;
    }
}

- (IBAction)menCacheClick:(id)sender {
    
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com/"];
    
    NSURLCache * urlCache = [NSURLCache sharedURLCache];
    urlCache.memoryCapacity = 1024 * 1024; // 1M
    
    // 创建请求
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.f];
    
    // 从请求中获取缓存
    NSCachedURLResponse * response = [urlCache cachedResponseForRequest:request];
    
    // 判断
    if (response != nil) { // 有缓存
        NSLog(@"有缓存，从缓存中获取数据");
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    self.connection = nil;
    
    // 没有缓存 创建connection请求
    NSLog(@"没有缓存，需要请求服务器");
    NSURLConnection * newConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    self.connection = newConnection;
}

#pragma mark - NSURLConnectionDataDelegate

- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response{
 
    NSLog(@"即将发送请求");
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"收到response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"收到数据，长度为 = %lu", [data length]);
}

// 并不知道为什么没走这个方法？？？？？
- (nullable NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    NSLog(@"将缓存输出");
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"加载完成");
}

@end
