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
@property (nonatomic, strong) UIImageView * contentImageView;
@end

@implementation FeedTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    
    _titleLabel = [self createLabel:[UIFont systemFontOfSize:16] titleColor:[UIColor blueColor]];
    
    [self addSubview:_titleLabel];
    _contentLabel = [self createLabel:[UIFont systemFontOfSize:15] titleColor:[UIColor grayColor]];
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    _usernameLabel = [self createLabel:[UIFont systemFontOfSize:15] titleColor:[UIColor grayColor]];
    [self addSubview:_usernameLabel];
    _timeLabel = [self createLabel:[UIFont systemFontOfSize:15] titleColor:[UIColor purpleColor]];
    [self addSubview:_timeLabel];
    
    _contentImageView = [[UIImageView alloc]init];
    [self addSubview:_contentImageView];
    
    //
    CGFloat spaceLeftAndRight = 20.f;
    CGFloat spaceTop = 10.f;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(spaceLeftAndRight);
        make.top.mas_equalTo(self).offset(spaceTop);
        make.right.mas_equalTo(self).offset(-spaceLeftAndRight);
        make.height.mas_equalTo(32);
    }];
    
    [@[_contentLabel, _usernameLabel, _contentImageView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_titleLabel);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(spaceTop);
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(spaceTop);
    }];
    
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentImageView.mas_bottom).offset(spaceTop);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_usernameLabel);
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
    self.usernameLabel.text = feedModel.username;
    self.contentLabel.text = feedModel.content;
    self.timeLabel.text = feedModel.time;
    self.contentImageView.image = feedModel.imageName.length > 0 ? [UIImage imageNamed:feedModel.imageName] : Nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
