//
//  DZSingle.m
//  productTest
//
//  Created by 杨岱臻 on 2017/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZSingle.h"

@implementation DZSingle

static DZSingle *defaultManager = nil;

+(DZSingle *)defaultManager
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (defaultManager == nil) {
            defaultManager = [[self alloc] init];
        }
    });
    return defaultManager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (defaultManager == nil) {
            defaultManager = [super allocWithZone:zone];
        }
    });
    return defaultManager;
}

//-(instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.name = @"single";
//    }
//    return self;
//}

-(id)copy
{
    return self;
}

@end
