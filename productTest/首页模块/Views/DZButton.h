//
//  DZButton.h
//  productTest
//
//  Created by 杨岱臻 on 2016/11/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZButton;

@protocol DZButtonDelegate <NSObject>

@required
-(void)buttonWithButton:(DZButton *)button;

@end

@interface DZButton : UIButton

@property (nonatomic, weak) id<DZButtonDelegate> delegate;

@end
