//
//  TemplateLayoutTableViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/22.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "TemplateLayoutTableViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "FeedModel.h"
#import "FeedTableViewCell.h"

@interface TemplateLayoutTableViewController ()
@property (nonatomic, strong) NSArray * prototypeEnititesFromJSON;
@property (nonatomic, strong) NSMutableArray * feedSections;
@end

@implementation TemplateLayoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.fd_debugLogEnabled = YES; // 调试log
    
//    [self testDataThen:^{
//        self.feedSections = @[].mutableCopy;
//        [self.feedSections addObject:self.prototypeEnititesFromJSON.mutableCopy];
//        [self.tableView reloadData];
//    }];
//    
    [self.tableView registerClass:[FeedTableViewCell class] forCellReuseIdentifier:@"FeedTableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [self testDataThen:^{
        self.feedSections = @[].mutableCopy;
        [self.feedSections addObject:self.prototypeEnititesFromJSON.mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)testDataThen:(void(^)(void))then{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 获取数据
        NSString * dataFielPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData * data = [NSData dataWithContentsOfFile:dataFielPath];
        NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray * feedDic = rootDic[@"feed"];
        
        // 字典转模型
        NSMutableArray * entites = @[].mutableCopy;
        [feedDic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [entites addObject:[[FeedModel alloc] initWithDictionary:obj]];
        }];
        self.prototypeEnititesFromJSON = entites;

        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.feedSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.feedSections[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FeedTableViewCell"];
    
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configCell:(FeedTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    cell.fd_enforceFrameLayout = NO;
    
    if (indexPath.row % 2 == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.feedModel = self.feedSections[indexPath.section][indexPath.row];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"FeedTableViewCell" configuration:^(id cell) {
        [self configCell:cell atIndexPath:indexPath];
    }];
}


@end
