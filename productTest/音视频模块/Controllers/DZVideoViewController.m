//
//  DZVideoViewController.m
//  productTest
//
//  Created by 杨岱臻 on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZVideoViewController.h"
#import "DZVideoCell.h"
#import "DZVideoModel.h"
#import "DZVideoViewController2.h"
#import "DZVideoViewController3.h"
#import "DZVideoViewController4.h"
#import "DZVideoViewController5.h"

@interface DZVideoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *array;

@end

@implementation DZVideoViewController

static NSString *cellID = @"cell";

#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        _tableView = tableView;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[DZVideoCell class] forCellReuseIdentifier:cellID];
        
        //添加约束
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        
        [self.view addConstraints:@[topConstraint, bottomConstraint, leftConstraint, rightConstraint]];
    }
    return _tableView;
}

-(NSArray *)array
{
    if (!_array) {
        DZVideoModel *videoModel2 = [[DZVideoModel alloc] init];
        videoModel2.name = @"通过AVPlayerLayer播放视频";
        videoModel2.vcClass = [DZVideoViewController2 class];
        
        DZVideoModel *videoModel3 = [[DZVideoModel alloc] init];
        videoModel3.name = @"通过AVPlayerViewController播放视频";
        videoModel3.vcClass = [DZVideoViewController3 class];
        
        DZVideoModel *videoModel4 = [[DZVideoModel alloc] init];
        videoModel4.name = @"通过MPMoviePlayerController播放视频";
        videoModel4.vcClass = [DZVideoViewController4 class];
        
        DZVideoModel *videoModel5 = [[DZVideoModel alloc] init];
        videoModel5.name = @"通过MPMoviePlayerViewController播放视频";
        videoModel5.vcClass = [DZVideoViewController5 class];
        
        _array = @[videoModel2, videoModel3, videoModel4, videoModel5];
    }
    return _array;
}

#pragma mark - view的回调
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];   
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isMemberOfClass:[DZVideoCell class]]) {
        DZVideoCell *videoCell = (DZVideoCell *)cell;
        videoCell.videoModel = self.array[indexPath.row];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    if ([cell isMemberOfClass:[DZVideoCell class]]) {
        DZVideoCell *videoCell = (DZVideoCell *)cell;
        Class vcClass = videoCell.videoModel.vcClass;
        id any = [[vcClass alloc] init];
        [self.navigationController pushViewController:any animated:YES];
    }
}

@end
