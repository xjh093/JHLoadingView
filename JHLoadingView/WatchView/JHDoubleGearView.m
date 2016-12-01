//
//  DoubleGearView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHDoubleGearView.h"

@implementation JHDoubleGearView

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
    
    CGRect frame1 = CGRectMake(0, 0, frame.size.width, frame.size.width);
    JHOutGearView *outGearView = [[JHOutGearView alloc] initWithFrame:frame1];
    
    CGFloat i2X = frame.size.width*0.35*0.5;
    CGFloat i2W = frame.size.width*0.65;
    CGRect frame2 = CGRectMake(i2X,i2X,i2W,i2W);
    JHInnerGearView *innerGearView = [[JHInnerGearView alloc] initWithFrame:frame2];
    
    [self addSubview:outGearView];
    [self addSubview:innerGearView];
}

@end

@implementation JHOutGearView

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
    
    CGFloat tW = 2;
    
    //圈
    CGFloat X = tW;
    CGFloat W = frame.size.width - X*2;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(X, X, W, W);
    view.layer.cornerRadius = W*0.5;
    view.layer.borderWidth = tW;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:view];
    
    
    CGFloat v1W = tW*3;
    CGFloat v1X = (W-v1W)*0.5;
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(v1X, v1X, v1W, v1W);
    view1.backgroundColor = [UIColor whiteColor];
    [view addSubview:view1];
    
    //齿
    CGFloat angle = 0;
    for (int i = 0; i < 30; i++)
    {
        if (0 == i%3) {
            JHToothesView *element = [[JHToothesView alloc]
                                      initWithFrame:CGRectMake(frame.size.width/2 - tW*0.5,
                                                               0,
                                                               tW,
                                                               frame.size.height)];
            element.transform = CGAffineTransformMakeRotation(angle);
            [self addSubview:element];
        }
        angle+=M_PI/180*6;
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(0),@(M_PI/180*360)];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 3;
    [self.layer addAnimation:animation forKey:@"jhrotate"];
    
}

@end


@implementation JHInnerGearView

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
    
    CGFloat tW = 2;
    
    //圈
    CGFloat X = tW;
    CGFloat W = frame.size.width - X*2;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(X, X, W, W);
    view.layer.cornerRadius = W*0.5;
    view.layer.borderWidth = tW;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:view];
    
    //齿
    CGFloat angle = 0;
    for (int i = 0; i < 30; i++)
    {
        if (0 == i%3) {
            JHToothesView *element = [[JHToothesView alloc]
                                      initWithFrame:CGRectMake(frame.size.width/2 - tW*0.5,
                                                               0,
                                                               tW,
                                                               frame.size.height)];
            element.transform = CGAffineTransformMakeRotation(angle);
            [self addSubview:element];
        }
        angle+=M_PI/180*6;
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(M_PI/180*360),@(0)];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 6;
    [self.layer addAnimation:animation forKey:@"jhrotate"];
    
}

@end


#define height1 0

@implementation JHToothesView

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

@end


