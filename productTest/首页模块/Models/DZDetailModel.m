//
//  DZDetailModel.m
//  productTest
//
//  Created by 杨岱臻 on 2016/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DZDetailModel.h"

@implementation DZDetailModel

-(instancetype)init
{
    if (self) {
        self = [super init];
    }
    self.image = [UIImage imageNamed:@"001"];
    
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    [self.image drawInRect:CGRectMake(0, 0, 200, 200)];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return self;
}

-(void)setGirlPictureString:(NSString *)girlPictureString
{
    _girlPictureString = girlPictureString;
    NSURL *url = [NSURL URLWithString:_girlPictureString];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(detailModelDownloadImageWithModel:)]) {
                [self.delegate detailModelDownloadImageWithModel:self];
            }
        });
    });
}

@end
