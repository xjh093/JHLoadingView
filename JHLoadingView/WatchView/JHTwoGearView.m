//
//  JHTwoGearView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHTwoGearView.h"

@implementation JHTwoGearView

- (instancetype)initWithFrame:(CGRect)frame tW:(CGFloat)tW
{
    self = [super initWithFrame:frame];
    if (self) {
        _tW = tW;
        [self initView:frame];
    }
    return self;
}

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
    
    CGFloat tW = _tW;
    
    //齿
    CGFloat angle = 0;
    for (int i = 0; i < 30; i++)
    {
        if (0 == i%5) {
            JHToothView *element = [[JHToothView alloc]
                                    initWithFrame:CGRectMake(frame.size.width/2 - tW*0.5,
                                                             0,
                                                             tW,
                                                             frame.size.height)];
            element.transform = CGAffineTransformMakeRotation(angle);
            [self addSubview:element];
        }
        angle+=M_PI/180*6;
    }
    
    //圈
    CGFloat X = tW - 1;
    CGFloat W = frame.size.width - X*2;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(X, X, W, W);
    view.layer.cornerRadius = W*0.5;
    view.layer.borderWidth = tW;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:view];
    
    //十字
    CGFloat v1W = tW*0.5;
    CGFloat v1X = (W-v1W)*0.5;
    CGFloat v1Y = (W-tW*2)*0.5;
    CGFloat v1H = tW*2;
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(v1X, v1Y, v1W, v1H);
    view1.backgroundColor = [UIColor whiteColor];
    [view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(v1Y, v1X, v1H, v1W);
    view2.backgroundColor = [UIColor whiteColor];
    [view addSubview:view2];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(0),@(M_PI/180*360)];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 3;
    [self.layer addAnimation:animation forKey:@"jhrotate"];
}

@end
