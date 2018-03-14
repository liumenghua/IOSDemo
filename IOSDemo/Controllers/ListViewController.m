//
//  ListViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/12.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "ListViewController.h"
#import "DeviceInfoViewController.h"
#import "UIViewController+Extension.h"
#import "LMHViewController.h"
#import "AppearanceView.h"
#import "MasonryViewController.h"
#import "UIApplicationView.h"
#import "KeyboardManagerView.h"

@interface ListViewController ()
@property (nonatomic, strong) NSArray * childItems;
@end

@implementation ListViewController
static NSString * const reuseID = @"reuseID";
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"首页";
        [self loadDate];
    }
    return self;
}

- (void)loadDate
{
    self.childItems = @[
                        [[DeviceInfoViewController alloc] initWithTitle:@"设备信息"],
                        [[LMHViewController alloc] initWithTitle:@"appearance" viewClass:[AppearanceView class]],
                        [[MasonryViewController alloc] initWithTitle:@"masonry的使用"],
                        [[LMHViewController alloc] initWithTitle:@"UIApplication详解" viewClass:[UIApplicationView class]],
                        [[LMHViewController alloc] initWithTitle:@"KeyboardManagerView" viewClass:[KeyboardManagerView class]]
                        ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.childItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.childItems[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = viewController.title;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *viewController = self.childItems[indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
