//
//  JHCubeView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHCubeView.h"

@interface JHCubeView()
@property (strong,  nonatomic) NSTimer      *timer;
@end

@implementation JHCubeView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
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
    self.backgroundColor = [UIColor whiteColor];

    [self jhAnimate];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)jhAnimate
{
    NSMutableArray *values = [NSMutableArray array];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 0.005;//加负号，可以左转
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(transform,M_PI,1,0,0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(transform,0, 0, 1 ,0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DRotate(transform,M_PI,0,1,0)]];
    
    CFTimeInterval duration = 1.5;
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"transform";
    animation1.values = values;
    //animation1.repeatCount = MAXFLOAT;
    animation1.duration = duration;
    [self.layer addAnimation:animation1 forKey:@"jh3drotate"];
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(jhAnimate) userInfo:nil repeats:YES];
    }
    return _timer;
}


@end

