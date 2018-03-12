//
//  LMHViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/12.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "LMHViewController.h"

@interface LMHViewController ()
@property (nonatomic, strong) Class viewClass;

@end

@implementation LMHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (id)initWithTitle:(NSString *)title viewClass :(Class)viewClass
{
    self = [super init];
    if (self) {
        self.title = title;
        self.viewClass = viewClass;
    }
    return self;
}

- (void)loadView
{
    self.view  = [self.viewClass new];
    self.view.backgroundColor = [UIColor whiteColor];
}
@end
