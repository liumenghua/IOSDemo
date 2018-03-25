//
//  FeedTableViewCell.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/22.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "FeedTableViewCell.h"
#import "FeedModel.h"
#import <Masonry.h>

@interface FeedTableViewCell()
@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, weak) UILabel * usernameLabel;
@property (nonatomic, weak) UILabel * contentLabel;
@property (nonatomic, weak) UILabel * timeLabel;
@property (nonatomic, weak) UILabel * testLabel;
@property (nonatomic, strong) UIImageView * contentImageView;
@end

@implementation FeedTableViewCell

// 纯代码自定义cell需要重写该方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    // TODO：
    // 出现一个神奇的问题：当我直接只用_或者self.获取到的成员变量来进行初始化操作的时候，重写的模型的set方法更新值不成功？？？
    // 如果新初始化一个对象再复制给成员变量的话 就可以。很神奇！！！
    // 比如下面的_titleLabel就不行。
//    _titleLabel = [self createLabel:[UIFont systemFontOfSize:16] titleColor:[UIColor blueColor]];
//    [self addSubview:_titleLabel];
    
    UILabel * titleLabel = [self createLabel:[UIFont systemFontOfSize:16] titleColor:[UIColor blueColor]];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel * contentLabel = [self createLabel:[UIFont systemFontOfSize:15] titleColor:[UIColor grayColor]];
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel * usernameLabel = [self createLabel:[UIFont systemFontOfSize:15] titleColor:[UIColor grayColor]];
    [self addSubview:usernameLabel];
    self.usernameLabel = usernameLabel;
    
    UILabel * timeLabel = [self createLabel:[UIFont systemFontOfSize:15] titleColor:[UIColor purpleColor]];
    [self addSubview:timeLabel];
    self.titleLabel = titleLabel;

    UIImageView * contentImageView = [[UIImageView alloc]init];
    [self addSubview:contentImageView];
    self.contentImageView = contentImageView;

    
    CGFloat spaceLeftAndRight = 20.f;
    CGFloat spaceTop = 10.f;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(spaceLeftAndRight);
        make.top.mas_equalTo(self).offset(spaceTop);
        make.right.mas_equalTo(self).offset(-spaceLeftAndRight);
        make.height.mas_equalTo(32);
    }];
    
    [@[contentLabel, usernameLabel, contentImageView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(titleLabel);
    }];

    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(spaceTop);
    }];

    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(spaceTop);
    }];

    [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentImageView.mas_bottom).offset(spaceTop);
    }];

    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(usernameLabel);
        make.right.mas_equalTo(self).offset(spaceLeftAndRight);
    }];
}


- (UILabel *)createLabel:(UIFont *)font titleColor:(UIColor *)titleColor{
    UILabel * label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = titleColor;
    return label;
}

- (void)setFeedModel:(FeedModel *)feedModel{
    _feedModel = feedModel;
    self.titleLabel.text = feedModel.title;
//    self.testLabel.text = feedModel.title;
    self.usernameLabel.text = feedModel.username;
    self.contentLabel.text = feedModel.content;
    self.timeLabel.text = feedModel.time;
    self.contentImageView.image = feedModel.imageName.length > 0 ? [UIImage imageNamed:feedModel.imageName] : Nil;
}



@end
