//
//  DZPerson.m
//  productTest
//
//  Created by 杨岱臻 on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DZPerson.h"

@implementation DZPerson

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.age = [aDecoder decodeIntegerForKey:@"age"];
    self.height = [aDecoder decodeDoubleForKey:@"height"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeDouble:self.height forKey:@"height"];
}

@end
