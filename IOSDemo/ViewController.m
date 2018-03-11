//
//  ViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/8.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "ViewController.h"
#import "DeviceInfoViewController.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSMutableArray *itemArray;
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation ViewController

static NSString * const reuseId = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupDate];
}

- (void)setupUI
{
    self.title = @"首页";
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 注册
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
}

- (void)setupDate
{
    _itemArray = [NSMutableArray arrayWithObjects:@"获取设备信息", nil];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    cell.textLabel.text = _itemArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pushToControllerWithAnimation:[[DeviceInfoViewController alloc]init]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)pushToControllerWithAnimation:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}




@end
