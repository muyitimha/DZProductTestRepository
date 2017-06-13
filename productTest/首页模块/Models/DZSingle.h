//
//  DZSingle.h
//  productTest
//
//  Created by 杨岱臻 on 2017/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZSingle : NSObject

@property (nonatomic, strong) NSString *name;

+(DZSingle *)defaultManager;

@end
