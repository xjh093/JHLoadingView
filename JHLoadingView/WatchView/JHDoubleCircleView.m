//
//  JHDoubleCircleView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHDoubleCircleView.h"

@implementation JHDoubleCircleView

- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame type:type];
    }
    return self;
}

- (void)initView:(CGRect)frame type:(NSInteger)type
{
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    view1.alpha = 0.5;
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = frame.size.width*0.5;
    [self addSubview:view1];
    
    if (type == 1) {
        
        UIView *view2 = [[UIView alloc] init];
        view2.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        view2.alpha = 0.5;
        view2.backgroundColor = [UIColor whiteColor];
        view2.layer.cornerRadius = frame.size.width*0.5;
        [self addSubview:view2];
        
        CFTimeInterval duration = 2;
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
        animation1.keyPath = @"transform.scale";
        animation1.values = @[@(0),@(1),@(0)];
        animation1.repeatCount = MAXFLOAT;
        animation1.duration = duration;
        [view1.layer addAnimation:animation1 forKey:@"jhacale1"];
        
        CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animation];
        animation2.keyPath = @"transform.scale";
        animation2.values = @[@(1),@(0),@(1)];
        animation2.repeatCount = MAXFLOAT;
        animation2.duration = duration;
        [view2.layer addAnimation:animation2 forKey:@"jhacale2"];
    }
    else
    {
        UIView *view2 = [[UIView alloc] init];
        view2.frame = CGRectMake(5, 5, frame.size.width-10, frame.size.height-10);
        view2.alpha = 0.5;
        view2.backgroundColor = [UIColor whiteColor];
        view2.layer.cornerRadius = (frame.size.width-10)*0.5;
        [self addSubview:view2];
        
        NSMutableArray *values1 = [NSMutableArray array];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9,1,1)]];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 0, 0, 1)]];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1,0.8,1)]];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0, 0, 1)]];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8,1,1)]];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)]];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1,0.7,1)]];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI+M_PI_4, 0, 0, 1)]];
        [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9,1,1)]];
        
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
        animation1.keyPath = @"transform";
        animation1.values = values1;
        animation1.repeatCount = MAXFLOAT;
//        animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        animation1.duration = 4;
        [view1.layer addAnimation:animation1 forKey:@"jh3d1"];
        animation1.duration = 6;
        [view2.layer addAnimation:animation1 forKey:@"jh3d2"];
    }
}

@end

