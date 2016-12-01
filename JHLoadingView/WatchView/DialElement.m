//
//  DialElement.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "DialElement.h"

#define height1 2
#define height2 1

@implementation DialElement

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame];
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *view1 = [[UIView alloc] init];
    UIView *view2 = [[UIView alloc] init];

    view1.frame = CGRectMake(0,
                             0,
                             frame.size.width,
                             frame.size.width + height1);
    
    view2.frame = CGRectMake(0,
                             frame.size.height - frame.size.width - height1,
                             frame.size.width,
                             frame.size.width + height1);

    view1.backgroundColor = [UIColor whiteColor];
    view2.backgroundColor = view1.backgroundColor;
    [self addSubview:view1];
    [self addSubview:view2];
}

//- (void)setBackgroundColor:(UIColor *)backgroundColor
//{
//    if (![[UIColor clearColor] isEqual:backgroundColor]) {
//        self.backgroundColor = [UIColor clearColor];
//    }
//}

@end
