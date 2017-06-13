//
//  DZVideoViewController3.m
//  productTest
//
//  Created by 杨岱臻 on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZVideoViewController3.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface DZVideoViewController3 ()

@property (nonatomic, weak) UIView *displayVideoView;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) AVPlayerViewController *playerViewController;

@end

@implementation DZVideoViewController3

#pragma mark - 控制器的回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"通过AVPlayerViewController播放视频";
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //建立player
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"minion_01" ofType:@"mp4"];
    videoPath = [NSString stringWithFormat:@"file://%@", videoPath];
    NSURL *url = [NSURL URLWithString:videoPath];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    //建立playerViewController
    self.playerViewController = [[AVPlayerViewController alloc] init];
    self.playerViewController.player = player;
    self.playerViewController.showsPlaybackControls = YES;
    
#ifdef __IPHONE_9_0
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 9.0) {
        self.playerViewController.allowsPictureInPicturePlayback = YES;
    }
#endif
}

#pragma mark - 其他回调
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:self.playerViewController animated:YES completion:nil];
    [self.playerViewController.player play];
}

@end
