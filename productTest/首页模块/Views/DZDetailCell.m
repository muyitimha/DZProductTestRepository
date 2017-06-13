//
//  DZDetailCell.m
//  productTest
//
//  Created by 杨岱臻 on 2016/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DZDetailCell.h"
#import "UIImageView+WebCache.h"

@interface DZDetailCell()

@property (nonatomic, strong) UIImageView *girlImageView;

@end

@implementation DZDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        NSLog(@"cell的底色被随机化了");
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.girlImageView removeConstraints:self.girlImageView.constraints];
    
    NSLayoutConstraint *girlTopConstraint = [NSLayoutConstraint constraintWithItem:self.girlImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
    
    NSLayoutConstraint *girlBottomConstraint = [NSLayoutConstraint constraintWithItem:self.girlImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
    
    NSLayoutConstraint *girlLeftConstraint = [NSLayoutConstraint constraintWithItem:self.girlImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    
    NSLayoutConstraint *girlWidthConstraint = [NSLayoutConstraint constraintWithItem:self.girlImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.girlImageView.image.size.width/3];
    
    //    NSLayoutConstraint *girlHeightConstraint = [NSLayoutConstraint constraintWithItem:self.girlImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.imageSize.height/3];
    
    [self.contentView addConstraints:@[girlTopConstraint, girlLeftConstraint, girlBottomConstraint]];
    [self.girlImageView addConstraints:@[girlWidthConstraint]];
}

#pragma mark - 懒加载
-(UIImageView *)girlImageView
{
    if (_girlImageView == nil) {
        _girlImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_girlImageView];
        _girlImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _girlImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(DZDetailModel *)model
{
    _model = model;
//    self.girlImageView.image = model.image;
    
    NSURL *url = [NSURL URLWithString:_model.girlPictureString];
    [self.girlImageView sd_setImageWithURL:url];
}

@end
