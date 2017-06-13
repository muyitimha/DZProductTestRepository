//
//  DZView.m
//  productTest
//
//  Created by 杨岱臻 on 2017/2/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZView.h"
#import "DZDrawView.h"

@interface DZView(){
    BOOL hasAddConstraintsToDzImageView;
}

@property (nonatomic, weak) DZDrawView *dzDrawView;

@end

@implementation DZView

-(DZDrawView *)dzDrawView
{
    if (_dzDrawView == nil) {
        DZDrawView *dzDrawView = [[DZDrawView alloc] init];
        _dzDrawView = dzDrawView;
        _dzDrawView.hasAddConstraintsToDzImageView = NO;
        _dzDrawView.translatesAutoresizingMaskIntoConstraints = NO;
        _dzDrawView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        [self addSubview:_dzDrawView];
    }
    return _dzDrawView;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        hasAddConstraintsToDzImageView = NO;
    }
    return self;
}

-(void)updateConstraints
{
    if (self.frame.size.width>0 && self.frame.size.height>0 && hasAddConstraintsToDzImageView == NO) {//仅当self有长宽时才添加约束
        //添加约束
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.dzDrawView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.dzDrawView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.dzDrawView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.dzDrawView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        
        [self addConstraints:@[topConstraint, leftConstraint]];
        [self.dzDrawView addConstraints:@[widthConstraint, heightConstraint]];
        
        hasAddConstraintsToDzImageView = YES;
        self.dzDrawView.hasAddConstraintsToDzImageView = YES;
    }

    [super updateConstraints];
}

+(BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
