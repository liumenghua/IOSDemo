//
//  ProgressViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/27.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController ()
@property (nonatomic, strong) UIProgressView * progressView;
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUI];
}

- (void)loadUI{
    // 注意 这里设置的高度对于UIProgressView来说是并没用的!!!依然是一两个px的高度 网上提供了一种放大的方法
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 100, 300, 80)];
    _progressView.progressTintColor = [UIColor redColor];
    _progressView.trackTintColor = [UIColor yellowColor];
    _progressView.layer.cornerRadius = 10.f;
    _progressView.progress = 0;
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    
    // 放大高度
    _progressView.transform = CGAffineTransformMakeScale(1.f, 10.f);
    
    [self.view addSubview:_progressView];
}

- (IBAction)testClick:(id)sender {

    _progressView.progress = 0.f;
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(progressChanged:) userInfo:nil repeats:YES];

}

- (void)progressChanged:(NSTimer *)timer{
    _progressView.progress += 0.00005;
    if (_progressView.progress >= 1.0) {
        [timer invalidate];
        timer = nil;
    }
}


@end
