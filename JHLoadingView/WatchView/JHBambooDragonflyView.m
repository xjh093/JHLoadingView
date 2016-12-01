//
//  JHBambooDragonflyView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHBambooDragonflyView.h"

@implementation JHBambooDragonflyView

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
    self.layer.cornerRadius = frame.size.width*0.5;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat width = 8;
    UIView *circle = [[UIView alloc] init];
    circle.frame = CGRectMake((frame.size.width-width)*0.5, (frame.size.height-width)*0.5, width, width);
    circle.backgroundColor = [UIColor whiteColor];
    circle.layer.cornerRadius = width*0.5;
    [self addSubview:circle];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(0),@(M_PI/180*360)];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 0.4;
    [self.layer addAnimation:animation forKey:@"jhrotate"];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,1,1,1,1);//画笔线的颜色
    
    //画椭圆
    UIColor *color = [UIColor whiteColor];
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextAddEllipseInRect(context, CGRectMake(17, 2, 6, 14)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextAddEllipseInRect(context, CGRectMake(17, 24, 6, 14)); //椭圆
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end





