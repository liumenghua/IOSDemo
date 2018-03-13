//
//  MasonryViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/12.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "MasonryViewController.h"
#import "LMHViewController.h"
#import "MasonryBasicView.h"
#import "MasonryRemakeView.h"

@interface MasonryViewController ()
@property (nonatomic, strong) NSArray * items;
@end

@implementation MasonryViewController
static NSString * const reuseID = @"reuseID2";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDate];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
}

- (void)loadDate
{
    self.items = @[
                   [[LMHViewController alloc] initWithTitle:@"MasonryBasicView" viewClass:[MasonryBasicView class]],
                   [[LMHViewController alloc] initWithTitle:@"MasonryRemakeView" viewClass:[MasonryRemakeView class]]
                   ];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = viewController.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.items[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
