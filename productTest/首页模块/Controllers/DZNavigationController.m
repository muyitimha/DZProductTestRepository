//
//  DZNavigationController.m
//  productTest
//
//  Created by 杨岱臻 on 16/5/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DZNavigationController.h"
#import "DZViewController.h"

@interface DZNavigationController ()

@end

@implementation DZNavigationController

-(instancetype)init
{
    self = [super init];
    if (self) {
        DZViewController *vc = [[DZViewController alloc] init];
        self = [self initWithRootViewController:vc];
        self.tabBarItem.image = [[UIImage imageNamed:@"001"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"001" ofType:@"png"];
//        NSLog(@"filePath:%@", filePath);
//        self.tabBarItem.image = [UIImage imageWithContentsOfFile:filePath];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//     Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
