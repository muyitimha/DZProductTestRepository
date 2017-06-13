//
//  DZDetailViewController.m
//  productTest
//
//  Created by 杨岱臻 on 2016/11/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DZDetailViewController.h"
#import "DZDetailCell.h"
#import "DZDetailModel.h"

@interface DZDetailViewController ()<UITableViewDelegate, UITableViewDataSource, DZDetailModelDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *girlPictureArray;

@end

@implementation DZDetailViewController

static NSString *cell = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Detail";
    self.tableView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    [self.tableView registerClass:[DZDetailCell class] forCellReuseIdentifier:cell];
    
    //纯代码实现sizeClass
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    [self.view addConstraints:@[topConstraint, bottomConstraint, leftConstraint, rightConstraint]];
}

#pragma mark - 懒加载
-(NSMutableArray *)girlPictureArray
{
    if (_girlPictureArray == nil) {
        _girlPictureArray = [NSMutableArray array];
        NSArray *addArray = @[@"http://d.hiphotos.baidu.com/image/pic/item/a08b87d6277f9e2fe47418c81b30e924b999f3a9.jpg", @"http://b.hiphotos.baidu.com/image/pic/item/8d5494eef01f3a29b41f18fa9c25bc315c607c2b.jpg", @"http://c.hiphotos.baidu.com/image/pic/item/0eb30f2442a7d93392f45b35a84bd11373f00113.jpg", @"http://a.hiphotos.baidu.com/image/pic/item/b999a9014c086e068d8c874b00087bf40ad1cb8e.jpg", @"http://e.hiphotos.baidu.com/image/pic/item/63d0f703918fa0ec44f7b0eb249759ee3d6ddb20.jpg", @"http://a.hiphotos.baidu.com/image/pic/item/9358d109b3de9c82d94b518a6e81800a19d8438c.jpg", @"http://f.hiphotos.baidu.com/image/pic/item/cdbf6c81800a19d8c9b6840c31fa828ba61e4605.jpg"];
        for (int i = 0; i < addArray.count; i++) {
            DZDetailModel *model = [[DZDetailModel alloc] init];
            model.delegate = self;
            model.girlPictureString = addArray[i];
            [_girlPictureArray addObject:model];
        }
    }
    return _girlPictureArray;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        _tableView = tableView;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.girlPictureArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:cell forIndexPath:indexPath];
    NSLog(@"%s", __FUNCTION__);
//    DZDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:cell];
    //让self注册了DZDetailCell后就可以省略下面这个判断了
//    if (detailCell == nil) {
//        detailCell = [[DZDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
//    }
    return detailCell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isMemberOfClass:[DZDetailCell class]]) {
        DZDetailModel *model = self.girlPictureArray[indexPath.row];
        DZDetailCell *detailCell = (DZDetailCell *)cell;
        detailCell.model = model;
    }
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZDetailModel *model = self.girlPictureArray[indexPath.row];
    return model.image.size.height/3 + 10 * 2;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - DZDetailModelDelegate
-(void)detailModelDownloadImageWithModel:(DZDetailModel *)detailModel
{
    [self.tableView reloadData];
}

#pragma mark -----

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"DZDetailViewController被销毁了");
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
