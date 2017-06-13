//
//  DZVideoViewController2.m
//  productTest
//
//  Created by 杨岱臻 on 2017/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZVideoViewController2.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface DZVideoViewController2 ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, weak) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) id timeToken;

@property (nonatomic, weak) UIView *displayVideoView;

@property (nonatomic, weak) UISlider *slider;

@end

@implementation DZVideoViewController2
    
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
//        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
//        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
//        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
//        
//        [self.view addConstraints:@[centerXConstraint, centerYConstraint]];
//        [_displayVideoView addConstraints:@[widthConstraint, heightConstraint]];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_displayVideoView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        
        [self.view addConstraints:@[topConstraint, bottomConstraint, leftConstraint, rightConstraint]];
    }
    return _displayVideoView;
}

-(UISlider *)slider
{
    if (!_slider) {
        UISlider *slider = [[UISlider alloc] init];
        _slider = slider;
        _slider.translatesAutoresizingMaskIntoConstraints = NO;
        [_slider addTarget:self action:@selector(sliderDidSlide:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderDidLeaveWithinHand:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_slider];
        
        //添加约束
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_slider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.displayVideoView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:44];
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:_slider attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_slider attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.displayVideoView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
        
        [self.view addConstraints:@[topConstraint, centerXConstraint, widthConstraint]];
    }
    return _slider;
}

#pragma mark - 控制器的回调
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayVideoView;
    self.slider;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = @"通过AVPlayerLayer播放视频";
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    //第一步：创建playerItem
    NSString *path = [[NSBundle mainBundle] pathForResource:@"minion_01" ofType:@"mp4"];
    path = [NSString stringWithFormat:@"file://%@", path];
    NSURL *url = [NSURL URLWithString:path];
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    [self.playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    //第二部：添加playerLayer到控制器的view的图层上
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer = playerLayer;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.displayVideoView.layer addSublayer:playerLayer];
    [self.player play];
    
    //第三步：给播放器添加进度更新
    __weak typeof(self) weakSelf = self;
    self.timeToken = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1000) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
    __strong typeof(weakSelf) strongSelf = weakSelf;
        CGFloat current = CMTimeGetSeconds(time);
        CGFloat duration = CMTimeGetSeconds(strongSelf.playerItem.duration);
        strongSelf.slider.value = current / duration;
    }];
    
    //第四步：给AVPlayerItem添加播放完成通知
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
//    AVCaptureSession *session = [[AVCaptureSession alloc] init];
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    
//    //输入
//    NSError *error = nil;
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
//    [session addInput:input];
//    
//    //输出
//    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
//    dispatch_queue_t queue = dispatch_queue_create("outputQueue", DISPATCH_QUEUE_SERIAL);
//    [output setSampleBufferDelegate:self queue:queue];
//    [session addOutput:output];
//    
//    //开始捕捉
//    [session startRunning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.playerLayer.frame = self.displayVideoView.layer.bounds;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.playerLayer.frame = self.displayVideoView.layer.bounds;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.player pause];
    [self.player removeTimeObserver:self.timeToken];
    self.timeToken = nil;
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

#pragma mark - 其他回调
-(void)sliderDidSlide:(UISlider *)slider
{
    if (self.timeToken) {
        [self.player pause];
    }
    
    CGFloat current = slider.value * CMTimeGetSeconds(self.playerItem.duration);
    [self.playerItem seekToTime:CMTimeMakeWithSeconds(current, 60) toleranceBefore:CMTimeMakeWithSeconds(0.5, 60) toleranceAfter:CMTimeMakeWithSeconds(0.5, 60)];
}

-(void)sliderDidLeaveWithinHand:(UISlider *)slider
{
    [self.player play];
}
    
#pragma mark - kvo回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus playStatus = [[change objectForKey:@"new"] integerValue];
        if (playStatus == AVPlayerStatusReadyToPlay) {
//            NSLog(@"正在播放视频,视频总长:%f秒", CMTimeGetSeconds(playerItem.duration));
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        CMTimeRange timeRange = playerItem.loadedTimeRanges.firstObject.CMTimeRangeValue;
        CGFloat startSeconds = CMTimeGetSeconds(timeRange.start);
        CGFloat durationSeconds = CMTimeGetSeconds(timeRange.duration);
//        NSLog(@"startSeconds:%f, durationSeconds:%f", startSeconds, durationSeconds);
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
}
    
#pragma mark - 通知回调
-(void)playbackFinished:(NSNotification *)notification
{
    NSLog(@"视频播放完成");
}

@end
