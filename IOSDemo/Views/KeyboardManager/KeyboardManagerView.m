//
//  KeyboardManagerView.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/14.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "KeyboardManagerView.h"
#import <Masonry.h>
@implementation KeyboardManagerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CGFloat space = 20.f;
    
    UITextField * firstTextField = [self createRoundedTextFieldWithPlacehoder:@"信息1"];
    [self addSubview:firstTextField];
    
    UITextField * secondTextField = [self createRoundedTextFieldWithPlacehoder:@"信息2"];
    [self addSubview:secondTextField];
    
    UITextField * thirdTextField = [self createRoundedTextFieldWithPlacehoder:@"信息3"];
    [self addSubview:thirdTextField];
    
    UITextField * fourthTextField = [self createRoundedTextFieldWithPlacehoder:@"信息4"];
    [self addSubview:fourthTextField];
    
    UITextField * fifthTextField = [self createRoundedTextFieldWithPlacehoder:@"信息5"];
    [self addSubview:fifthTextField];
    
    UITextField * sixtTextField = [self createRoundedTextFieldWithPlacehoder:@"信息6"];
    [self addSubview:sixtTextField];
    
    // 根据大小计算间隙
    [@[firstTextField, secondTextField, thirdTextField, fourthTextField, fifthTextField, sixtTextField] mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:44 leadSpacing:20 tailSpacing:100];
    [@[firstTextField, secondTextField, thirdTextField, fourthTextField, fifthTextField, sixtTextField] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(space);
        make.right.equalTo(self).offset(-space);
    }];
}

- (UITextField *)createRoundedTextFieldWithPlacehoder:(NSString *)placeHoder
{
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectZero];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = placeHoder;
    
    return textField;
}
@end
