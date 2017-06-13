//
//  DZDrawView.m
//  productTest
//
//  Created by 杨岱臻 on 2017/2/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZDrawView.h"

@implementation DZDrawView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.hasAddConstraintsToDzImageView == YES) {
        //第一种方法
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, self.frame.size.width*0.2, self.frame.size.height*0.2);
        CGPathAddCurveToPoint(path, NULL, self.frame.size.width*0.3, self.frame.size.height*0.2, self.frame.size.width*0.4, self.frame.size.height*0.3, self.frame.size.width*0.4, self.frame.size.height*0.4);
        CGAffineTransform affineTransform = CGAffineTransformMakeTranslation(0, 0);
        CGPathAddEllipseInRect(path, &affineTransform, CGRectMake(self.frame.size.width*0.4, self.frame.size.height*0.4, 15, 10));
//        CGPathAddArc(path, NULL, self.frame.size.width*0.4, self.frame.size.height*0.4, 15, 0, M_PI*2, NO);
        CGContextAddPath(ctx, path);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1].CGColor);
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineWidth(ctx, 1);
        CGContextSetLineJoin(ctx, kCGLineJoinRound);
//        CGContextStrokePath(ctx);
        CGContextFillPath(ctx);
        CGPathRelease(path);
        
        
        //第二种方法
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:CGPointMake(self.frame.size.width*0.2, self.frame.size.height*0.2)];
//        [path addCurveToPoint:CGPointMake(self.frame.size.width*0.4, self.frame.size.height*0.4) controlPoint1:CGPointMake(self.frame.size.width*0.3, self.frame.size.height*0.2) controlPoint2:CGPointMake(self.frame.size.width*0.4, self.frame.size.height*0.3)];
////        [path addQuadCurveToPoint:CGPointMake(self.frame.size.width*0.4, self.frame.size.height*0.4) controlPoint:CGPointMake(self.frame.size.width*0.4, self.frame.size.height*0.2)];
//        [path addArcWithCenter:CGPointMake(self.frame.size.width*0.4, self.frame.size.height*0.4) radius:15 startAngle:0 endAngle:M_PI*2 clockwise:YES];
//        CGContextAddPath(ctx, path.CGPath);
//        CGContextSetLineCap(ctx, kCGLineCapRound);
//        CGContextSetLineJoin(ctx, kCGLineJoinRound);
//        CGContextSetLineWidth(ctx, 1);
//        CGContextStrokePath(ctx);
        
    }
}



@end
