//
//  DZVideoNavigationController.m
//  productTest
//
//  Created by 杨岱臻 on 2017/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZVideoNavigationController.h"
#import "DZVideoViewController.h"

@interface DZVideoNavigationController ()

@end

@implementation DZVideoNavigationController

-(instancetype)init
{
    if (self = [super init]) {
        DZVideoViewController *vc = [[DZVideoViewController alloc] init];
        self = [self initWithRootViewController:vc];
        self.tabBarItem.image = [[UIImage imageNamed:@"001"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
