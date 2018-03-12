//
//  DeviceInfoViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/8.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "DeviceInfoViewController.h"
#import "DeviceInfo.h"

@interface DeviceInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableDictionary * itemDic;
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation DeviceInfoViewController

static NSString * const reuseId = @"cell2";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self loadDate];
    
    for (int i = 0; i < 5; i ++) {
        NSLog(@"uuid %zd = %@", i,[NSUUID UUID].UUIDString);
    }

}

- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 注册
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
    
}

- (void)loadDate
{
    _itemDic = [NSMutableDictionary dictionary];
    
    NSString * uuid = [DeviceInfo getRandomUUID];
    NSString * keychainUUID = [DeviceInfo getDeviceID];
    NSString * idfa = [DeviceInfo getIDFA];
    NSString * idfv = [DeviceInfo getIDFV];
    
    NSString * deviceName = [DeviceInfo getDeviceName];
    NSString * deviceSystemName = [DeviceInfo getDeviceSystemName];
    NSString * deviceSystemVersion = [DeviceInfo getSystemVersion];
    
    NSString * carrier = [DeviceInfo getCarrier];
    NSString * networkType = [DeviceInfo getNetworkType];
    
    [self.itemDic setObject:uuid forKey:@"uuid"];
    [self.itemDic setObject:keychainUUID forKey:@"keychainUUID"];
    [self.itemDic setObject:idfa forKey:@"idfa"];
    [self.itemDic setObject:idfv forKey:@"idfv"];
    
    [self.itemDic setObject:deviceName forKey:@"deviceName"];
    [self.itemDic setObject:deviceSystemName forKey:@"deviceSystemName"];
    [self.itemDic setObject:deviceSystemVersion forKey:@"deviceSystemVersion"];
    
    [self.itemDic setObject:carrier forKey:@"carrier"];
    [self.itemDic setObject:networkType forKey:@"networkType"];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemDic.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", _itemDic.allKeys[indexPath.row], [_itemDic objectForKey:_itemDic.allKeys[indexPath.row]]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
