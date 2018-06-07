//
//  GearView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHGearView.h"

@interface JHTwoGearView()
@property (strong,  nonatomic) JHGearView   *gearView1;
@property (strong,  nonatomic) JHGearView   *gearView2;
@property (strong,  nonatomic) NSTimer      *timer;
@property (assign,  nonatomic) double        angle;
@end

@implementation JHTwoGearView

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
    JHGearView *gview1 = [[JHGearView alloc] initWithFrame:CGRectMake(0, 0, 25,25) tW:3];
    JHGearView *gview2 = [[JHGearView alloc] initWithFrame:CGRectMake(15,15,25,25) tW:3];
    [self addSubview:gview1];
    [self addSubview:gview2];
    _gearView1 = gview1;
    _gearView2 = gview2;
    
    // 不使用 内部的定时器
    [gview2 setValue:@(YES) forKey:@"stopTimer"];
    
    [self jhAnimate];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)jhAnimate
{
    _angle = _angle + 0.1;
    if (_angle > 6.28) { // PI 3.14
        _angle = 0;
    }
    _gearView2.transform = CGAffineTransformMakeRotation(-_angle);
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(jhAnimate) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end

@interface JHGearView()
@property (strong,  nonatomic) NSTimer      *timer;
@property (assign,  nonatomic) BOOL          stopTimer;
@property (assign,  nonatomic) double        angle;
@end

CGFloat _tW = 5;
@implementation JHGearView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}

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
    
    [self jhAnimate];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)jhAnimate
{
    _angle = _angle + 0.1;
    if (_angle > 6.28) { // PI 3.14
        _angle = 0;
    }
    self.transform = CGAffineTransformMakeRotation(_angle);
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(jhAnimate) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)setStopTimer:(BOOL)stopTimer{
    if (stopTimer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end


#define height1 0

@implementation JHToothView

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


