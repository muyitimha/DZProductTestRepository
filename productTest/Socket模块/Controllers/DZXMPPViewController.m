//
//  DZXMPPViewController.m
//  productTest
//
//  Created by 杨岱臻 on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZXMPPViewController.h"
#import "XMPPFramework.h"

@interface DZXMPPViewController ()<XMPPStreamDelegate>{
    XMPPStream *_xmppStream;
}

@property (nonatomic, weak) UIButton *connectButton;
@property (nonatomic, weak) UIButton *logoutButton;

@end

@implementation DZXMPPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    self.title = @"xmpp";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置约束
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && window.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//iphone竖屏
        //connectButton的约束
        NSLayoutConstraint *connectButtonHorizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.connectButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *connectButtonTopConstraint = [NSLayoutConstraint constraintWithItem:self.connectButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:50];
        [self.view addConstraints:@[connectButtonHorizontalCenterConstraint, connectButtonTopConstraint]];
        //logoutButton的约束
        NSLayoutConstraint *logoutButtonHorizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *logoutButtonVerticalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self.view addConstraints:@[logoutButtonHorizontalCenterConstraint, logoutButtonVerticalCenterConstraint]];
    }
    
    if ((window.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && window.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) || (window.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular && window.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact)) {//iphone横屏
        //connectButton的约束
        NSLayoutConstraint *connectButtonVerticalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.connectButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        NSLayoutConstraint *connectButtonLeftConstraint = [NSLayoutConstraint constraintWithItem:self.connectButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100];
        [self.view addConstraints:@[connectButtonVerticalCenterConstraint, connectButtonLeftConstraint]];
        //logoutButton的约束
        NSLayoutConstraint *logoutButtonHorizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *logoutButtonVerticalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self.view addConstraints:@[logoutButtonHorizontalCenterConstraint, logoutButtonVerticalCenterConstraint]];
    }
    
}

#pragma mark - 懒加载
-(UIButton *)connectButton
{
    if (_connectButton == nil) {
        UIButton *connectButton = [[UIButton alloc] init];
        _connectButton = connectButton;
        _connectButton.titleLabel.numberOfLines = 0;
        _connectButton.titleLabel.font = [UIFont systemFontOfSize:UIFont.smallSystemFontSize];
        _connectButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_connectButton setTitle:@"对XMPP服务器进行连接" forState:UIControlStateNormal];
        [_connectButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_connectButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_connectButton setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_connectButton];
        _connectButton.layer.cornerRadius = 7;
        _connectButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_connectButton addTarget:self action:@selector(connectButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加约束
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_connectButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_connectButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        [_connectButton addConstraints:@[widthConstraint, heightConstraint]];
    }
    return _connectButton;
}

-(UIButton *)logoutButton
{
    if (_logoutButton == nil) {
        UIButton *logoutButton = [[UIButton alloc] init];
        _logoutButton = logoutButton;
        _logoutButton.titleLabel.numberOfLines = 0;
        _logoutButton.titleLabel.font = [UIFont systemFontOfSize:UIFont.smallSystemFontSize];
        _logoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_logoutButton setTitle:@"对XMPP服务器进行注销" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_logoutButton setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_logoutButton];
        _logoutButton.layer.cornerRadius = 7;
        _logoutButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_logoutButton addTarget:self action:@selector(logoutButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加约束
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_logoutButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_logoutButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        [_logoutButton addConstraints:@[widthConstraint, heightConstraint]];
    }
    return _logoutButton;
}

#pragma mark - 屏幕将要旋转时调用
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    //去掉connectButton与其他控件现有的约束
    for (NSLayoutConstraint *constraint in self.view.constraints) {
        if ([constraint.firstItem isEqual:self.connectButton]) {
            [self.view removeConstraint:constraint];
        }
    }
    //去掉logoutButton与其他控件现有的约束
    for (NSLayoutConstraint *constraint in self.view.constraints) {
        if ([constraint.firstItem isEqual:self.logoutButton]) {
            [self.view removeConstraint:constraint];
        }
    }
    
    //添加新的约束
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//iphone竖屏
        //connectButton的约束
        NSLayoutConstraint *connectButtonHorizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.connectButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *connectButtonTopConstraint = [NSLayoutConstraint constraintWithItem:self.connectButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:50];
        [self.view addConstraints:@[connectButtonHorizontalCenterConstraint, connectButtonTopConstraint]];
        //logoutButton的约束
        NSLayoutConstraint *logoutButtonHorizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *logoutButtonVerticalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self.view addConstraints:@[logoutButtonHorizontalCenterConstraint, logoutButtonVerticalCenterConstraint]];
    }
    
    if ((newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) || (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular && newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact)) {//iphone横屏
        //connectButton的约束
        NSLayoutConstraint *connectButtonVerticalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.connectButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        NSLayoutConstraint *connectButtonLeftConstraint = [NSLayoutConstraint constraintWithItem:self.connectButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100];
        [self.view addConstraints:@[connectButtonVerticalCenterConstraint, connectButtonLeftConstraint]];
        //logoutButton的约束
        NSLayoutConstraint *logoutButtonHorizontalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *logoutButtonVerticalCenterConstraint = [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self.view addConstraints:@[logoutButtonHorizontalCenterConstraint, logoutButtonVerticalCenterConstraint]];
    }
}

#pragma mark - XMPPStream的代理
//与xmpp服务器连接成功后调用
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"成功连接");
    //发送密码给服务器
    NSError *error = nil;
    if (![_xmppStream authenticateWithPassword:@"one9stand" error:&error]) {
        NSLog(@"%@", error);
    }
}

//与xmpp服务器断开后调用，如果有错误代表非正常断开，没有则为正常断开
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    if (error) {
        NSLog(@"连接失败");
    }else{
        NSLog(@"连接正常断开");
    }
}

//登录xmpp服务器的密码正确后调用
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"成功登录xmpp服务器");
    //向服务器发送在线消息
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}

//登录xmpp服务器的密码错误后调用
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"登录xmpp服务器失败");
}

#pragma mark - the others
-(void)connectButtonDidClick:(UIButton *)connectButton
{
    //1.初始化XMPPStream
    _xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

    //2.连接到服务器（传一个JID）
    XMPPJID *myJID = [XMPPJID jidWithUser:@"zhangsan" domain:@"yangdaizhendemacbook-air.local" resource:@"iphone"];//设置登录用户JID
    _xmppStream.myJID = myJID;
    _xmppStream.hostName = @"127.0.0.1";//设置服务器地址
    _xmppStream.hostPort = 5222;
    NSError *error = nil;
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        NSLog(@"%@", error);
    }
}

-(void)logoutButtonDidClick:(UIButton *)logoutButton
{
    //1.发送离线消息
    XMPPPresence *logoutPresence = [XMPPPresence presenceWithType:@"unavailable"];//如果是在线的话就用available
    [_xmppStream sendElement:logoutPresence];
    
    //2.与XMPP服务器断开连接
    [_xmppStream disconnect];
}


@end
