//
//  UITableView+Appearance.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/12.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "UITableView+Appearance.h"


@implementation UITableView (Appearance)

- (void)setseparatorLineHidden:(BOOL)hidden
{
    self.separatorStyle = hidden ? UITableViewCellAccessoryNone : UITableViewCellSeparatorStyleSingleLine;
}

@end
