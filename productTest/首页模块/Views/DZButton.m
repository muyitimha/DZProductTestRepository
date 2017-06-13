//
//  DZButton.m
//  productTest
//
//  Created by 杨岱臻 on 2016/11/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DZButton.h"

@implementation DZButton

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ([self.delegate respondsToSelector:@selector(buttonWithButton:)]) {
        [self.delegate buttonWithButton:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
