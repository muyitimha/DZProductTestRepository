//
//  DZVideoViewController5.m
//  productTest
//
//  Created by 杨岱臻 on 2017/6/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZVideoViewController5.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DZVideoViewController5 ()

@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerViewController;

@end

@implementation DZVideoViewController5

#pragma mark - 控制器的回调
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通过MPMoviePlayerViewController播放视频";
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"minion_01" ofType:@"mp4"]];
    self.moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
}

#pragma mark - 其他回调
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:self.moviePlayerViewController animated:YES completion:nil];
}

@end
