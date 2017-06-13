//
//  DZTabBarController.m
//  productTest
//
//  Created by 杨岱臻 on 16/5/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DZTabBarController.h"
#import "DZNavigationController.h"
#import "DZVideoNavigationController.h"

@interface DZTabBarController ()

@end

@implementation DZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor greenColor];
    
    DZNavigationController *nav1 = [[DZNavigationController alloc] init];
    nav1.tabBarItem.title = @"nav1";
    
    DZVideoNavigationController *nav2 = [[DZVideoNavigationController alloc] init];
    nav2.tabBarItem.title = @"nav2";
    
    DZNavigationController *nav3 = [[DZNavigationController alloc] init];
    nav3.tabBarItem.title = @"nav3";
    
    DZNavigationController *nav4 = [[DZNavigationController alloc] init];
    nav4.tabBarItem.title = @"nav4";
    
    self.viewControllers = @[nav1, nav2, nav3, nav4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
