//
//  DZVideoViewController4.m
//  productTest
//
//  Created by 杨岱臻 on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZVideoViewController4.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DZVideoViewController4 ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

@property (nonatomic, weak) UIView *displayVideoView;

@end

@implementation DZVideoViewController4

#pragma mark - 懒加载
-(UIView *)displayVideoView
{
    if (!_displayVideoView) {
        UIView *displayVideoView = [[UIView alloc] init];
        _displayVideoView = displayVideoView;
        _displayVideoView.translatesAutoresizingMaskIntoConstraints = NO;
        _displayVideoView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        [self.view addSubview:_displayVideoView];
        
        //添加约束
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        
        [self.view addConstraints:@[topConstraint, bottomConstraint, leftConstraint, rightConstraint]];
    }
    return _displayVideoView;
}

#pragma mark - 控制器的回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"通过MPMoviePlayerController播放视频";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"minion_01" ofType:@"mp4"];
    videoPath = [NSString stringWithFormat:@"file://%@", videoPath];
    NSURL *url = [NSURL URLWithString:videoPath];
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [self.moviePlayerController prepareToPlay];
    
//    moviePlayerController.shouldAutoplay = YES;
//    moviePlayerController.controlStyle = MPMovieControlStyleDefault;
//    self.moviePlayerController.fullscreen = YES;
//    moviePlayerController.allowsAirPlay = YES;
    
    self.moviePlayerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.displayVideoView addSubview:self.moviePlayerController.view];
    [self.moviePlayerController play];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.moviePlayerController.view.frame = self.displayVideoView.bounds;
}

@end
