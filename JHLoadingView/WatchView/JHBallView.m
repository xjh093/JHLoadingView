//
//  JHBallView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHBallView.h"

@implementation JHBallView

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
    
    UIView *ball1 = [self jhSetupBall:CGRectMake(1.6, 0, 8, 8)];
    UIView *ball2 = [self jhSetupBall:CGRectMake(11.2, 0, 8, 8)];
    UIView *ball3 = [self jhSetupBall:CGRectMake(20.8, 0, 8, 8)];
    UIView *ball4 = [self jhSetupBall:CGRectMake(30.4, 0, 8, 8)];
    
    NSMutableArray *values1 = [NSMutableArray array];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,36,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"transform";
    animation1.values = values1;
    animation1.repeatCount = MAXFLOAT;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation1.duration = 1.3;
    [ball1.layer addAnimation:animation1 forKey:@"jh3d1"];
    animation1.duration = 1.2;
    [ball2.layer addAnimation:animation1 forKey:@"jh3d3"];
    animation1.duration = 1.1;
    [ball3.layer addAnimation:animation1 forKey:@"jh3d2"];
    animation1.duration = 1;
    [ball4.layer addAnimation:animation1 forKey:@"jh3d4"];
}

- (UIView *)jhSetupBall:(CGRect)frame
{
    UIView *ball = [[UIView alloc] init];
    ball.frame = frame;
    ball.layer.cornerRadius = 4;
    ball.backgroundColor = [UIColor whiteColor];
    [self addSubview:ball];
    return ball;
}

@end

