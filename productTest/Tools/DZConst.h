//
//  DZConst.h
//  productTest
//
//  Created by 杨岱臻 on 2017/2/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define DZLog(...) NSLog(@"%s %d \n %@\n\n", __func__, __LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define DZLog(...)
#endif

@interface DZConst : NSObject

@end

UIKIT_EXTERN NSString * const okString;
