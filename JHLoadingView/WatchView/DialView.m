//
//  DialElementView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "DialView.h"
#import "DialElement.h"
@implementation DialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame];
        [self initNumber:frame]; //表盘数字 3,6,9,12
    }
    return self;
}

#pragma mark - 表盘刻度
- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat angle = 0;
    for (int i = 0; i < 30; i++)
    {
        if (0 == i%5) {
            DialElement *element = [[DialElement alloc]
                                    initWithFrame:CGRectMake(frame.size.width/2 - frame.origin.x,
                                                             0,
                                                             frame.origin.x,
                                                             frame.size.height)];
            element.transform = CGAffineTransformMakeRotation(angle);
            [self addSubview:element];
        }
        angle+=M_PI/180*6;
    }
}

#pragma mark - 表盘数字
- (void)initNumber:(CGRect)frame
{
    CGFloat width = 10;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(0, 0, width, width);
    label1.text = @"12";
    label1.center = CGPointMake(frame.size.width/2, 10);
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0, 0, width, width);
    label2.text = @"3";
    label2.center = CGPointMake(frame.size.width - width*0.5-2, frame.size.height/2);
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(0, 0, width, width);
    label3.text = @"6";
    label3.center = CGPointMake(frame.size.width/2+2, frame.size.height - 10);
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(0, 0, width, width);
    label4.text = @"9";
    label4.center = CGPointMake(width, frame.size.height/2);
    
    label1.font = label2.font = label3.font = label4.font = [UIFont systemFontOfSize:8];
    label1.textColor = label2.textColor = label3.textColor = label4.textColor = [UIColor whiteColor];
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    [self addSubview:label4];
}

@end
