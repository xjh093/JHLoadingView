//
//  JHBallView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHBallView.h"

@interface JHBallView()
@property (strong,  nonatomic) UIView       *ball1;
@property (strong,  nonatomic) UIView       *ball2;
@property (strong,  nonatomic) UIView       *ball3;
@property (strong,  nonatomic) UIView       *ball4;

@property (strong,  nonatomic) NSTimer      *timer1;
@property (strong,  nonatomic) NSTimer      *timer2;
@property (strong,  nonatomic) NSTimer      *timer3;
@property (strong,  nonatomic) NSTimer      *timer4;
@end

@implementation JHBallView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [_timer1 invalidate];
        [_timer2 invalidate];
        [_timer3 invalidate];
        [_timer4 invalidate];
        
        _timer1 = nil;
        _timer2 = nil;
        _timer3 = nil;
        _timer4 = nil;
    }
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
    
    _ball1 = [self jhSetupBall:CGRectMake(1.6, 0, 8, 8)];
    _ball2 = [self jhSetupBall:CGRectMake(11.2, 0, 8, 8)];
    _ball3 = [self jhSetupBall:CGRectMake(20.8, 0, 8, 8)];
    _ball4 = [self jhSetupBall:CGRectMake(30.4, 0, 8, 8)];
    
    [self jhAnimate1];
    [self jhAnimate2];
    [self jhAnimate3];
    [self jhAnimate4];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] addTimer:self.timer2 forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] addTimer:self.timer3 forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] addTimer:self.timer4 forMode:NSRunLoopCommonModes];
    
}

- (void)jhAnimate1
{
    NSMutableArray *values1 = [NSMutableArray array];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,36,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"transform";
    animation1.values = values1;
    //animation1.repeatCount = MAXFLOAT;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation1.duration = 1.3;
    [_ball1.layer addAnimation:animation1 forKey:@"jh3d1"];
}

- (void)jhAnimate2
{
    NSMutableArray *values1 = [NSMutableArray array];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,36,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"transform";
    animation1.values = values1;
    //animation1.repeatCount = MAXFLOAT;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation1.duration = 1.2;
    [_ball2.layer addAnimation:animation1 forKey:@"jh3d3"];
}

- (void)jhAnimate3
{
    NSMutableArray *values1 = [NSMutableArray array];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,36,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"transform";
    animation1.values = values1;
    //animation1.repeatCount = MAXFLOAT;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation1.duration = 1.1;
    [_ball3.layer addAnimation:animation1 forKey:@"jh3d2"];
}

- (void)jhAnimate4
{
    NSMutableArray *values1 = [NSMutableArray array];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,36,0)]];
    [values1 addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0,0)]];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"transform";
    animation1.values = values1;
    //animation1.repeatCount = MAXFLOAT;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation1.duration = 1;
    [_ball4.layer addAnimation:animation1 forKey:@"jh3d4"];
}

- (NSTimer *)timer1{
    if (!_timer1) {
        _timer1 = [NSTimer scheduledTimerWithTimeInterval:1.3 target:self selector:@selector(jhAnimate1) userInfo:nil repeats:YES];
    }
    return _timer1;
}

- (NSTimer *)timer2{
    if (!_timer2) {
        _timer2 = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(jhAnimate2) userInfo:nil repeats:YES];
    }
    return _timer2;
}

- (NSTimer *)timer3{
    if (!_timer3) {
        _timer3 = [NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(jhAnimate3) userInfo:nil repeats:YES];
    }
    return _timer3;
}

- (NSTimer *)timer4{
    if (!_timer4) {
        _timer4 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(jhAnimate4) userInfo:nil repeats:YES];
    }
    return _timer4;
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

