//
//  DZViewController.m
//  productTest
//
//  Created by 杨岱臻 on 16/5/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DZNavigationController.h"
#import "DZViewController.h"
#import "DZButton.h"
#import "DZDetailViewController.h"
#import "DZView.h"
#import "DZConst.h"
#import "DZPerson.h"
#import "DZSingle.h"
#import "DZXMPPViewController.h"

@interface DZViewController ()<DZButtonDelegate, CAAnimationDelegate, UIPopoverPresentationControllerDelegate, NSURLSessionDataDelegate>

typedef int(^missBlock)();

@property (nonatomic, weak) DZButton *button;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) DZView *dzView;
@property (nonatomic, copy) NSString *(^theBlock)(int);
@property (nonatomic, copy) missBlock block;
@property (nonatomic, copy) NSString *dzString;

@end

@implementation DZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSSet *set = [[NSSet alloc] initWithObjects:@1,@"2",@"3",@"4",@"1", nil];
    
    NSLog(@"%@---", okString);
    
    self.theBlock = ^NSString *(int a){
        return nil;
    };
    
    NSObject *person = [[NSObject alloc] init];
    __block typeof(person) blockperson = person;
    __weak typeof(self) weakself = self;
    self.block = ^int(){
        __strong typeof(weakself) strongself = weakself;
        blockperson = [[NSObject alloc] init];
        return 20;
    };
    
    self.block();
    self.theBlock(30);
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    self.navigationItem.title = @"哈哈哈哈";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(didClickRefreshButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(didClickBookMarkButton)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
#ifdef __IPHONE_10_4
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 10.4) {
        sdfeergdfg
        sgdfg
        dfsg
    }
#else
    if ([UIDevice currentDevice].systemVersion.doubleValue <= 10.3) {
        
    }
    
#endif
    
    //纯代码实现sizeClass
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iPhone的竖屏
        [self.button setTitle:@"iPhone竖屏" forState:UIControlStateNormal];
        //添加约束
        NSLayoutConstraint *upConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        
        [self.view addConstraints:@[upConstraint, leftConstraint]];
        [self.button addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if ((self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular || UIUserInterfaceSizeClassCompact) && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {//如果是iPhone的横屏
        [self.button setTitle:@"iPhone横屏" forState:UIControlStateNormal];
        //添加约束
        NSLayoutConstraint *upConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
        
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        
        [self.view addConstraints:@[upConstraint, rightConstraint]];
        [self.button addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iPad的横竖屏
        [self.button setTitle:@"iPad横竖屏" forState:UIControlStateNormal];
        //添加约束
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        
        [self.view addConstraints:@[centerXConstraint, centerYConstraint]];
        [self.button addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iPhone竖屏
        //添加约束
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90];
        
        [self.view addConstraints:@[centerXConstraint, centerYConstraint]];
        [self.imageView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if ((self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact || self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {//如果iPhone是横屏
        //添加约束
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90];
        
        [self.view addConstraints:@[rightConstraint, bottomConstraint]];
        [self.imageView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iPad横竖屏
        //添加约束
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90];
        
        [self.view addConstraints:@[rightConstraint, bottomConstraint]];
        [self.imageView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iPhone竖屏
        //添加约束
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
        
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        [self.view addConstraints:@[topConstraint, rightConstraint]];
        [self.dzView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if ((self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact | self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {//如果是iPhone横屏
        //添加约束
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        [self.view addConstraints:@[centerXConstraint, bottomConstraint]];
        [self.dzView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iPad
        //添加约束
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        [self.view addConstraints:@[centerYConstraint, leftConstraint]];
        [self.dzView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    //下载一张图片
//    NSThread *thread = [[NSThread alloc] initWithBlock:^{
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/5ab5c9ea15ce36d358d27ee43ef33a87e850b114.jpg"]];
//        [self performSelectorOnMainThread:@selector(changePicture:) withObject:data waitUntilDone:YES];
//    }];
//    [thread start];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/5ab5c9ea15ce36d358d27ee43ef33a87e850b114.jpg"]];
        [self performSelectorOnMainThread:@selector(changePicture:) withObject:data waitUntilDone:YES];
    });
    
    
    
#pragma mark - block的用法
    //block1
    NSString *(^myBlock)(int, NSString *) = ^NSString *(int a, NSString *string){
        return nil;
    };
    myBlock(32, @"sre");
    
    //block2
    typedef int(^mathBlock)(int a);
    mathBlock myMathBlock = ^int(int b){
        return 50;
    };
    myMathBlock(30);
    
    //block3
    void(^block3)();
    block3 = ^void(){
        
    };
    
#pragma mark - struct的用法
    //struct1
    struct struct1{
        int a;
        int b;
    };
    struct struct1 myStruct1 = {3, 5};
    
    //struct2
    struct struct2{
        int a;
        int b;
    }myStruct2;
    myStruct2.a = 10;
    struct struct2 swer = {10,20};
    
    //struct3
    struct {
        int a;
        int b;
    }myStruct3;
    myStruct3.a = 10;
    
    //struct4
    typedef struct{
        int a;
        int b;
    }Struct4;
    Struct4 myStruct4 = {4, 5};
    
    //struct5
    typedef struct struct5{
        int a;
        int b;
    }MyStruct5;
    MyStruct5 myStruct5 = {4, 7};
    struct struct5 struct10 = {3, 7};
    
#pragma mark - enum的用法
    //enum1
    enum enum1{
        myA = 0,
        myB,
        myC
    }myEnum1;
    myEnum1 = myA;
    enum enum1 myEnum2 = myB;
    
    //enum3
    enum{
        myA2 = 0,
        myB2,
        myC2
    }myEnum3;
    myEnum3 = myC2;
    
    //enum4
    typedef enum enum4{
        myA3 = 0,
        myB3,
        myC3
    }MyEnum4;
    enum enum4 myEnum5 = myC3 | myA3;
    MyEnum4 myEnum4 = myC3;
    
    //enum6
    typedef NS_ENUM(NSInteger, DZEnum){
        DZEnumStart = 0,
        DZEnumSupose,
        DZEnumStop
    };
    DZEnum dzEnum = DZEnumStart | DZEnumSupose;
    
    //enum7
    typedef NS_OPTIONS(NSInteger, DZOptionEnum){
        DZOptionEnumStart = 1 << 0,
        DZOptionEnumSupose,
        DZOptionEnumStop
    };
    DZOptionEnum dzOptionEnum = DZOptionEnumStart | DZOptionEnumStop;
    
#pragma mark - 指向指针的指针
    int a = 10;
    int *p = &a;
    int **q = &p;
    
    *p = a;
    *p = 20;
    **q = 30;
    
    char c[1024];
    char *o = c;
    
#pragma mark - 手势
    //轻拍
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDidWork:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    //轻扫
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureDidWork:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    //长按
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureDidWork:)];
    longPressGestureRecognizer.minimumPressDuration = 1;
    longPressGestureRecognizer.allowableMovement = 10;
    [self.view addGestureRecognizer:longPressGestureRecognizer];
    
    //平移
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDidWork:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    //捏合
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureDidWork:)];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    
    //旋转
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureDidWork:)];
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    
    //边缘
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanGestureDidWork:)];
    screenEdgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePanGestureRecognizer];
    
#pragma mark - 通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notificationDidWork:) name:@"dzNotification" object:nil];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidAppear:animated];
    
    [self.dzView setNeedsUpdateConstraints];
    
    //self.button的iOS动画
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSValue *transformAnimationValue1 = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    CATransform3D transform3D2 = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    NSValue *transformAnimationValue2 = [NSValue valueWithCATransform3D:transform3D2];
    CATransform3D transform3D3 = CATransform3DRotate(transform3D2, M_PI_2, 0, 0, 1);
    NSValue *transformAnimationValue3 = [NSValue valueWithCATransform3D:transform3D3];
    CATransform3D transform3D4 = CATransform3DRotate(transform3D3, M_PI_2, 0, 0, 1);
    NSValue *transformAnimationValue4 = [NSValue valueWithCATransform3D:transform3D4];
    CATransform3D transform3D5 = CATransform3DRotate(transform3D4, M_PI_2, 0, 0, 1);
    NSValue *transformAnimationValue5 = [NSValue valueWithCATransform3D:transform3D5];
    transformAnimation.values = @[transformAnimationValue1, transformAnimationValue2, transformAnimationValue3, transformAnimationValue4, transformAnimationValue5];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    positionAnimation.fromValue = @(1);
    positionAnimation.toValue = @(0.2);
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[transformAnimation, positionAnimation];
    group.duration = 3;
    group.repeatCount = 3;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.beginTime = CACurrentMediaTime() + 2;
    group.delegate = self;
    [self.button.layer addAnimation:group forKey:@"group"];
    
    //self.imageView的iOS动画
    //    CABasicAnimation *imageViewPositionAnimation = [CABasicAnimation animation];
    //    imageViewPositionAnimation.keyPath = @"position";
    //    imageViewPositionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width - 100, self.view.frame.size.height - 200)];
    //    imageViewPositionAnimation.duration = 3;
    //    imageViewPositionAnimation.speed = 2.0f;
    //    imageViewPositionAnimation.repeatCount = 3;
    //    imageViewPositionAnimation.autoreverses = YES;
    //    imageViewPositionAnimation.removedOnCompletion = NO;
    //    imageViewPositionAnimation.fillMode = kCAFillModeForwards;
    //    imageViewPositionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    imageViewPositionAnimation.beginTime = CACurrentMediaTime() + 2;
    //    [self.imageView.layer addAnimation:imageViewPositionAnimation forKey:nil];
    
    //    CAKeyframeAnimation *imageViewPositionKeyframeAnimation = [CAKeyframeAnimation animation];
    //    imageViewPositionKeyframeAnimation.keyPath = @"position";
    //    NSValue *ivpaValue1 = [NSValue valueWithCGPoint:self.imageView.center];
    //    NSValue *ivpaValue2 = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    //    NSValue *ivpaValue3 = [NSValue valueWithCGPoint:CGPointMake(400, 200)];
    //    NSValue *ivpaValue4 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    //    imageViewPositionKeyframeAnimation.values = @[ivpaValue1, ivpaValue2, ivpaValue3, ivpaValue4];
    //    imageViewPositionKeyframeAnimation.keyTimes = @[@0, @0.50, @0.75, @1.0];
    //    imageViewPositionKeyframeAnimation.duration = 10;
    //    imageViewPositionKeyframeAnimation.repeatCount = 3;
    //    imageViewPositionKeyframeAnimation.removedOnCompletion = NO;
    //    imageViewPositionKeyframeAnimation.fillMode = kCAFillModeForwards;
    //    imageViewPositionKeyframeAnimation.beginTime = CACurrentMediaTime() + 2;
    //    imageViewPositionKeyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    imageViewPositionKeyframeAnimation.autoreverses = YES;
    //    imageViewPositionKeyframeAnimation.speed = 1.5f;
    //    imageViewPositionKeyframeAnimation.calculationMode = kCAAnimationCubic;
    //    imageViewPositionKeyframeAnimation.biasValues = @[@1, @1, @1, @1];
    //    imageViewPositionKeyframeAnimation.tensionValues = @[@1, @1, @1, @1];
    //    imageViewPositionKeyframeAnimation.continuityValues = @[@1, @1, @1, @1];
    //    [self.imageView.layer addAnimation:imageViewPositionKeyframeAnimation forKey:nil];
    
    //    CAKeyframeAnimation *imageViewPositionKeyframeAnimation = [CAKeyframeAnimation animation];
    //    imageViewPositionKeyframeAnimation.keyPath = @"position";
    //    CGMutablePathRef path = CGPathCreateMutable();
    //    CGPathMoveToPoint(path, nil, self.imageView.center.x, self.imageView.center.y);
    //    CGPathAddLineToPoint(path, nil, 500, 300);
    //    CGPathAddLineToPoint(path, nil, 200, 400);
    //    CGPathAddLineToPoint(path, nil, 100, 100);
    //    imageViewPositionKeyframeAnimation.keyTimes = @[@0, @0.25, @0.75, @1.0];
    //    imageViewPositionKeyframeAnimation.path = path;
    //    imageViewPositionKeyframeAnimation.duration = 10;
    //    imageViewPositionKeyframeAnimation.repeatCount = 3;
    //    imageViewPositionKeyframeAnimation.removedOnCompletion = NO;
    //    imageViewPositionKeyframeAnimation.fillMode = kCAFillModeForwards;
    //    imageViewPositionKeyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    imageViewPositionKeyframeAnimation.autoreverses = YES;
    //    imageViewPositionKeyframeAnimation.speed = 1.5f;
    //    imageViewPositionKeyframeAnimation.beginTime = CACurrentMediaTime() + 2;
    //    CFRelease(path);
    //    imageViewPositionKeyframeAnimation.calculationMode = kCAAnimationLinear;
    //    [self.imageView.layer addAnimation:imageViewPositionKeyframeAnimation forKey:nil];
    
    //    CAKeyframeAnimation *imageViewPositionKeyframeAnimation = [CAKeyframeAnimation animation];
    //    imageViewPositionKeyframeAnimation.keyPath = @"position";
    //    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    //    [bezierPath moveToPoint:CGPointMake(self.imageView.center.x, self.imageView.center.y)];
    //    [bezierPath addCurveToPoint:CGPointMake(200, 400) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(100, 100)];
    //    [bezierPath addCurveToPoint:CGPointMake(400, 200) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(100, 100)];
    //    [bezierPath addCurveToPoint:CGPointMake(100, 100) controlPoint1:CGPointMake(200, 200) controlPoint2:CGPointMake(200, 200)];
    //    imageViewPositionKeyframeAnimation.path = bezierPath.CGPath;
    //    imageViewPositionKeyframeAnimation.duration = 10;
    //    imageViewPositionKeyframeAnimation.repeatCount = 3;
    //    imageViewPositionKeyframeAnimation.removedOnCompletion = NO;
    //    imageViewPositionKeyframeAnimation.fillMode = kCAFillModeForwards;
    //    imageViewPositionKeyframeAnimation.autoreverses = YES;
    //    imageViewPositionKeyframeAnimation.keyTimes = @[@0, @0.25, @0.75, @1];
    //    imageViewPositionKeyframeAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //    imageViewPositionKeyframeAnimation.calculationMode = kCAAnimationLinear;
    //    [self.imageView.layer addAnimation:imageViewPositionKeyframeAnimation forKey:nil];
    
    CABasicAnimation *imageViewBasicAnimation = [CABasicAnimation animation];
    imageViewBasicAnimation.keyPath = @"transform.rotation.x";
    imageViewBasicAnimation.toValue = @(M_PI);
    imageViewBasicAnimation.duration = 3;
    imageViewBasicAnimation.speed = 2.0f;
    imageViewBasicAnimation.repeatCount = 3;
    imageViewBasicAnimation.autoreverses = YES;
    imageViewBasicAnimation.removedOnCompletion = NO;
    imageViewBasicAnimation.fillMode = kCAFillModeForwards;
    imageViewBasicAnimation.beginTime = CACurrentMediaTime() + 2;
    imageViewBasicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    imageViewBasicAnimation.delegate = self;
    [self.imageView.layer addAnimation:imageViewBasicAnimation forKey:@"imageViewBasicAnimation"];
    
    id e = [CAAnimation defaultValueForKey:@"timingFunction"];
}

#pragma mark - 点击图书按钮后
-(void)didClickBookMarkButton
{
    DZDetailViewController *detailVC = [[DZDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 点击刷新按钮后
-(void)didClickRefreshButton
{
    DZXMPPViewController *xmppVC = [[DZXMPPViewController alloc] init];
    xmppVC.modalPresentationStyle = UIModalPresentationPopover;
    xmppVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    UIPopoverPresentationController *pop = xmppVC.popoverPresentationController;
    pop.delegate = self;
    pop.barButtonItem = self.navigationItem.leftBarButtonItem;
    pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
    [self presentViewController:xmppVC animated:YES completion:nil];
}

#pragma mark - 在主线程中更换self.button背景图片
-(void)changePicture:(NSData *)data
{
    UIImage *image = [UIImage imageWithData:data];
    @synchronized (self) {
        [self.button setBackgroundImage:image forState:UIControlStateNormal];
    }
    
}

#pragma mark - 懒加载
-(DZButton *)button
{
    if (_button == nil) {
        DZButton *button = [DZButton buttonWithType:UIButtonTypeCustom];
        _button = button;
        [_button setTitle:@"hello world" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor redColor];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.delegate = self;
        [_button addTarget:self action:@selector(DZHaha) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
    }
    return _button;
}

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        _imageView.backgroundColor = [UIColor yellowColor];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

-(DZView *)dzView
{
    if (_dzView == nil) {
        DZView *dzView = [[DZView alloc] init];
        _dzView = dzView;
        _dzView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_dzView];
    }
    return _dzView;
}

#pragma mark - 屏幕将要旋转时
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iPhone的竖屏
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if ([constraint.firstItem isEqual:self.button]) {
                [self.view removeConstraint:constraint];
            }
        }
        for (NSLayoutConstraint *constraint in self.button.constraints) {
            if (constraint.secondItem == nil) {
                [self.button removeConstraint:constraint];
            }
        }
        [self.button setTitle:@"iPhone竖屏" forState:UIControlStateNormal];
        //添加约束
        NSLayoutConstraint *upConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        
        [self.view addConstraints:@[upConstraint, leftConstraint]];
        [self.button addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if ((newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular || newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) && newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {//如果是iPhone的横屏
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if ([constraint.firstItem isEqual:self.button]) {
                [self.view removeConstraint:constraint];
            }
        }
        for (NSLayoutConstraint *constraint in self.button.constraints) {
            if (constraint.secondItem == nil) {
                [self.button removeConstraint:constraint];
            }
        }
        [self.button setTitle:@"iPhone横屏" forState:UIControlStateNormal];
        //添加约束
        NSLayoutConstraint *upConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
        
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
        
        [self.view addConstraints:@[upConstraint, rightConstraint]];
        [self.button addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iphone竖屏
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if ([constraint.firstItem isEqual:self.imageView]) {
                [self.view removeConstraint:constraint];
            }
        }
        for (NSLayoutConstraint *constraint in self.imageView.constraints) {
            if (constraint.secondItem == nil) {
                [self.imageView removeConstraint:constraint];
            }
        }
        //添加约束
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90];
        
        [self.view addConstraints:@[centerXConstraint, centerYConstraint]];
        [self.imageView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if ((newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact || newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) && newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {//如果是iPhone横屏
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if ([constraint.firstItem isEqual:self.imageView]) {
                [self.view removeConstraint:constraint];
            }
        }
        for (NSLayoutConstraint *constraint in self.imageView.constraints) {
            if (constraint.secondItem == nil) {
                [self.imageView removeConstraint:constraint];
            }
        }
        //添加约束
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90];
        
        [self.view addConstraints:@[rightConstraint, bottomConstraint]];
        [self.imageView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {//如果是iPhone竖屏
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if ([constraint.firstItem isEqual:self.dzView]) {
                [self.view removeConstraint:constraint];
            }
        }
        for (NSLayoutConstraint *constraint in self.dzView.constraints) {
            if (constraint.secondItem == nil) {
                [self.dzView removeConstraint:constraint];
            }
        }
        //添加约束
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10];
        
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        [self.view addConstraints:@[topConstraint, rightConstraint]];
        [self.dzView addConstraints:@[widthConstraint, heightConstraint]];
    }
    
    if ((newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact || newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) && newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {//如果是iPhone横屏
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if ([constraint.firstItem isEqual:self.dzView]) {
                [self.view removeConstraint:constraint];
            }
        }
        for (NSLayoutConstraint *constraint in self.dzView.constraints) {
            if (constraint.secondItem == nil) {
                [self.dzView removeConstraint:constraint];
            }
        }
        //添加约束
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.dzView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
        
        [self.view addConstraints:@[centerXConstraint, bottomConstraint]];
        [self.dzView addConstraints:@[widthConstraint, heightConstraint]];
    }
}

#pragma mark - DZButtonDelegate
-(void)buttonWithButton:(DZButton *)button
{
    /* UIAlertController的用法 */
//    NSLog(@"按钮的内容是---%@", button.currentTitle);
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"此乃大明国境" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDestructive handler:nil];
//    [alertController addAction:action];
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"先不做决定" style:UIAlertActionStyleCancel handler:nil];
//    [alertController addAction:action2];
//    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"赖在这里" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:action3];
//    alertController.popoverPresentationController.sourceView = self.view;
//    alertController.popoverPresentationController.sourceRect = CGRectMake(100, 100, 100, 100);
//    [self presentViewController:alertController animated:NO completion:nil];
    
    /* UIPopoverController的用法 */
//    DZDetailViewController *detailVC = [[DZDetailViewController alloc] init];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"123" style:UIBarButtonItemStylePlain target:nil action:nil];
//    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular && self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
//        UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:detailVC];
//        [popVC presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }else{
//        [self.navigationController pushViewController:detailVC animated:NO];
//    }
    
    /* UIPopoverPresentationController的用法 */
    DZDetailViewController *detailVC = [[DZDetailViewController alloc] init];
    detailVC.modalPresentationStyle = UIModalPresentationPopover;
    detailVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    UIPopoverPresentationController *popover = detailVC.popoverPresentationController;
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popover.barButtonItem = self.navigationItem.rightBarButtonItem;
    popover.delegate = self;
    [self presentViewController:detailVC animated:YES completion:nil];
    
    //沙盒中的各个文件夹
//    NSLog(@"%@", [[NSBundle mainBundle] bundlePath]);
//    NSLog(@"%@", [NSBundle mainBundle]);
//    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES).firstObject);
//    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject);
//    NSLog(@"%@", NSTemporaryDirectory());
//    NSLog(@"%@", NSHomeDirectory());
//    NSLog(@"%@", [[NSBundle mainBundle] pathForResource:@"Brand Assets-700-568h@2x" ofType:@"png"]);
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"27dd3f158f4a6a53bd8550ac0670a4ce" ofType:@"jpg"];
//    NSLog(@"%@", [UIImage imageWithContentsOfFile:filePath]);
//    UIImage *image = [UIImage imageNamed:@"27dd3f158f4a6a53bd8550ac0670a4ce.jpg"];
//    NSLog(@"%@", image);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *url = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/6a63f6246b600c33fe5527171e4c510fd8f9a1c5.jpg"];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:data];
//        NSLog(@"%@", image);
//    });
//    NSArray *array = @[@1, @2, @3, @4, @"32e", self];
//    [array writeToFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"ydz.plist"] atomically:YES];
    
    //进行偏好设置
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:@"ydz" forKey:@"dz"];
//    [userDefaults synchronize];
//    NSString *dz = [userDefaults objectForKey:@"dz"];
//    NSLog(@"%@", dz);
    
    //kvc
//    [self setValue:@"yangdaizhen" forKey:@"dzString"];
//    NSLog(@"%@", self.dzString);
    
    //kvo
//    [self addObserver:self forKeyPath:@"dzString" options:NSKeyValueObservingOptionNew context:NULL];
//    self.dzString = @"dzString";
    
    //NSThread
//    NSThread *thread = [[NSThread alloc] initWithBlock:^{
//        NSLog(@"创建子线程");
//    }];
//    [thread start];
    
    //隐式操控线程
//    [self performSelectorInBackground:nil withObject:nil];
//    [self performSelectorOnMainThread:nil withObject:nil waitUntilDone:YES];
    
    //GCD
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t queue2 = dispatch_queue_create("haha", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(queue2, ^{
//        NSLog(@"没有阻塞");
//    });
//    NSLog(@"执行完毕");
    
    //NSOperation
//    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:nil selector:nil object:nil];
//    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        
//    }];
//    [blockOperation addExecutionBlock:^{
//        
//    }];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:blockOperation];
    
    //NSURLSession发get请求
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489655289489&di=d37672a14e185e5406a4821f3434810b&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fe850352ac65c10387629cc6ab7119313b17e89c6.jpg"];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (!error) {
//            NSLog(@"%@", [UIImage imageWithData:data]);
//        }
//    }];
//    [dataTask resume];
    
    //NSURLSession发post请求
//    NSURL *url = [NSURL URLWithString:@""];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [@"" dataUsingEncoding:NSUTF8StringEncoding];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (!error && data) {
//            NSLog(@"%@", [UIImage imageWithData:data]);
//        }
//    }];
//    [dataTask resume];
    
    //NSURLSessionUploadTask
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"dzConfiguration"];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    request.HTTPMethod = @"POST";
//    request.timeoutInterval = 30;
//    NSDictionary *dic = @{@"name":@"jack",
//                        @"age":@24
//                        };
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data];
//    [uploadTask resume];
    
    //发出通知
//    NSDictionary *dic = @{@"time":@"24",
//                          @"money":@"12345"
//                          };
//    NSNotification *notification = [[NSNotification alloc] initWithName:@"dzNotification" object:nil userInfo:dic];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    //归档
//    DZPerson *person = [[DZPerson alloc] init];
//    person.name = @"Rose";
//    person.age = 20;
//    person.height = 45;
//    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:person];
    
    //解档
//    id personDecoded = [NSKeyedUnarchiver unarchiveObjectWithData:personData];
//    if ([personDecoded isMemberOfClass:[DZPerson class]]) {
//        NSLog(@"personDecoded:%@", personDecoded);
//    }
    
    //创建单例
//    DZSingle *single = [DZSingle defaultManager];
//    DZSingle *allocSingle = [[DZSingle alloc] init];
//    DZSingle *copySingle = [single copy];
//    //DZSingle *mutableCopySingle = [allocSingle mutableCopy];
//    NSLog(@"%p,%p,%p", single, allocSingle, copySingle);
    
//    int a[10] = {1,2,3};
//    int *p = a;
//    char *b = "dfsgfsg";
//    char c[10] = "rtyert";
//    printf("p指针的字节长:%ld\n", sizeof(p));
    
    
}

-(void)DZHaha {
    NSLog(@"按钮被点击了");
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim
{
//    NSLog(@"%@", [CAAnimation ]);
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    NSLog(@"%s-----%@", __FUNCTION__, [anim class]);
}

#pragma mark - UIPopoverPresentationControllerDelegate
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationFullScreen;
}

-(UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
    DZNavigationController *nav = [[DZNavigationController alloc] initWithRootViewController:controller.presentedViewController];
    controller.presentedViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissDetailVC)];
    return nav;
}

#pragma mark - NSURLSessionDataDelegate
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    
}



#pragma mark - the others
-(void)updateViewConstraints
{
    [super updateViewConstraints];
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"dzString"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s", __FUNCTION__);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"self.dzString被改了！");
}

-(void)tapGestureDidWork:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSLog(@"轻拍手势被触发了:%@", tapGestureRecognizer);
}

-(void)swipeGestureDidWork:(UISwipeGestureRecognizer *)swipeGestureRecognizer
{
    NSLog(@"轻扫手势被触发了:%@", swipeGestureRecognizer);
}

-(void)longPressGestureDidWork:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    NSLog(@"长按手势被触发了:%@", longPressGestureRecognizer);
}

-(void)panGestureDidWork:(UIPanGestureRecognizer *)panGestureRecognizer
{
    NSLog(@"平移手势被触发了:%@", panGestureRecognizer);
    CGPoint point = [panGestureRecognizer translationInView:self.view];
    self.view.transform = CGAffineTransformTranslate(self.view.transform, point.x, point.y);
    [panGestureRecognizer setTranslation:CGPointZero inView:self.view];
}

-(void)pinchGestureDidWork:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    NSLog(@"捏合手势被触发了:%@", pinchGestureRecognizer);
//    NSLog(@"%f", pinchGestureRecognizer.scale);
    CGFloat scale = pinchGestureRecognizer.scale;
    self.view.transform = CGAffineTransformScale(self.view.transform, scale, scale);
    pinchGestureRecognizer.scale = 1;
}

-(void)rotationGestureDidWork:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    NSLog(@"旋转手势被触发了:%@", rotationGestureRecognizer);
//    NSLog(@"%f---", rotationGestureRecognizer.rotation);
    self.view.transform = CGAffineTransformRotate(self.view.transform, rotationGestureRecognizer.rotation);
    rotationGestureRecognizer.rotation = 0;
}

-(void)screenEdgePanGestureDidWork:(UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer
{
    NSLog(@"边缘手势被触发了");
}

-(void)notificationDidWork:(id)sender
{
    NSLog(@"%@", sender);
}

-(void)dismissDetailVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
