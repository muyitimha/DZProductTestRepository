//
//  DZConst.m
//  productTest
//
//  Created by 杨岱臻 on 2017/2/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZConst.h"

@implementation DZConst

-(instancetype)init
{
    if (self = [super init]) {
        //弹性控件系数,如果是iPhone就用屏幕宽度除以414，否则为1
        NSInteger springControlMultiplier = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone ? [UIScreen mainScreen].bounds.size.width / 414 : 1;
    }
    return self;
}

@end

NSString * const okString = @"mlgbhahaha";
