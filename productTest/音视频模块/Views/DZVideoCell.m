//
//  DZVideoCell.m
//  productTest
//
//  Created by 杨岱臻 on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZVideoCell.h"
#import "DZVideoModel.h"

@implementation DZVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setVideoModel:(DZVideoModel *)videoModel
{
    _videoModel = videoModel;
    self.textLabel.text = _videoModel.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
