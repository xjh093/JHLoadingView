//
//  JHDoubleCircleView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHDoubleCircleView.h"

@interface JHDoubleCircleView()
@property (strong,  nonatomic) UIView       *view1;
@property (strong,  nonatomic) UIView       *view2;
@property (strong,  nonatomic) NSTimer      *timer;
@property (strong,  nonatomic) NSTimer      *timer1;
@property (strong,  nonatomic) NSTimer      *timer2;
@end

@implementation JHDoubleCircleView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [_timer invalidate];
        [_timer1 invalidate];
        [_timer2 invalidate];
        
        _timer = nil;
        _timer1 = nil;
        _timer2 = nil;
    }
}

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
    _view1 = view1;
    
    if (type == 1) {
        
        UIView *view2 = [[UIView alloc] init];
        view2.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        view2.alpha = 0.5;
        view2.backgroundColor = [UIColor whiteColor];
        view2.layer.cornerRadius = frame.size.width*0.5;
        [self addSubview:view2];
        _view2 = view2;
        
        [self jhAnimate];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    else
    {
        UIView *view2 = [[UIView alloc] init];
        view2.frame = CGRectMake(5, 5, frame.size.width-10, frame.size.height-10);
        view2.alpha = 0.5;
        view2.backgroundColor = [UIColor whiteColor];
        view2.layer.cornerRadius = (frame.size.width-10)*0.5;
        [self addSubview:view2];
        _view2 = view2;
        
        [self jhAnimate1];
        [self jhAnimate2];
        [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] addTimer:self.timer2 forMode:NSRunLoopCommonModes];
    }
}

- (void)jhAnimate
{
    CFTimeInterval duration = 2;
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"transform.scale";
    animation1.values = @[@(0),@(1),@(0)];
    //animation1.repeatCount = MAXFLOAT;
    animation1.duration = duration;
    [_view1.layer addAnimation:animation1 forKey:@"jhacale1"];
    
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animation];
    animation2.keyPath = @"transform.scale";
    animation2.values = @[@(1),@(0),@(1)];
    //animation2.repeatCount = MAXFLOAT;
    animation2.duration = duration;
    [_view2.layer addAnimation:animation2 forKey:@"jhacale2"];
}

- (void)jhAnimate1
{
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
    //animation1.repeatCount = MAXFLOAT;
    
    animation1.duration = 4;
    [_view1.layer addAnimation:animation1 forKey:@"jh3d1"];
}

- (void)jhAnimate2
{
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
    //animation1.repeatCount = MAXFLOAT;
    
    animation1.duration = 6;
    [_view2.layer addAnimation:animation1 forKey:@"jh3d2"];
}


- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jhAnimate) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (NSTimer *)timer1{
    if (!_timer1) {
        _timer1 = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(jhAnimate1) userInfo:nil repeats:YES];
    }
    return _timer1;
}

- (NSTimer *)timer2{
    if (!_timer2) {
        _timer2 = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(jhAnimate2) userInfo:nil repeats:YES];
    }
    return _timer2;
}

@end

