//
//  DZDetailModel.h
//  productTest
//
//  Created by 杨岱臻 on 2016/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DZDetailModel;

@protocol DZDetailModelDelegate <NSObject>

@required
-(void)detailModelDownloadImageWithModel:(DZDetailModel *)detailModel;

@end

@interface DZDetailModel : NSObject

@property (nonatomic, copy) NSString *girlPictureString;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id<DZDetailModelDelegate> delegate;

@end
