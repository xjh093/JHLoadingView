//
//  JHHourglassView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHHourglassView.h"

@interface JHHourglassView()

@property (weak,    nonatomic) UIView       *upMaskView;
@property (weak,    nonatomic) UIView       *downMaskView;
@property (weak,    nonatomic) UIView       *sandView;

@property (strong,  nonatomic) NSTimer      *timer;

@end

@implementation JHHourglassView

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
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = YES;
    
    [self jhSetupViews];
    [self jhSetupMethods];
}

- (void)jhSetupViews
{
    //开平方
    CGFloat uW = sqrt(self.frame.size.width*self.frame.size.width*0.5);
    
    //上倒三角
    UIView *upView = [[UIView alloc] init];
    upView.frame = CGRectMake(0, 0, uW, uW);
    upView.backgroundColor = [UIColor whiteColor];
    upView.transform = CGAffineTransformMakeRotation(M_PI_4);
    upView.center = CGPointMake(upView.frame.size.width*0.5,0);
    [self addSubview:upView];
    
    //下正三角
    UIView *downView = [[UIView alloc] init];
    downView.frame = CGRectMake(0, 0, uW, uW);
    downView.backgroundColor = [UIColor whiteColor];
    downView.transform = CGAffineTransformMakeRotation(M_PI_4);
    downView.center = CGPointMake(upView.frame.size.width*0.5,upView.frame.size.height);
    [self addSubview:downView];
    
    //上遮罩
    UIView *upMaskView = [[UIView alloc] init];
    upMaskView.backgroundColor = self.backgroundColor;
    upMaskView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    [self addSubview:upMaskView];
    _upMaskView = upMaskView;
    
    //下遮罩
    UIView *downMaskView = [[UIView alloc] init];
    downMaskView.backgroundColor = self.backgroundColor;
    downMaskView.frame = CGRectMake(0, self.frame.size.height*0.5, self.frame.size.width,self.frame.size.height*0.5);
    [self addSubview:downMaskView];
    _downMaskView = downMaskView;
    
    //下落
    UIView *sandView = [[UIView alloc] init];
    sandView.frame = CGRectMake(self.frame.size.width*0.5-0.8,self.frame.size.height*0.5-0.5,1.5, 0);
    sandView.backgroundColor = [UIColor whiteColor];
    [self addSubview:sandView];
    _sandView = sandView;
}

- (void)jhSetupMethods
{
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)jhResetFrame
{
    CGRect frame1 = _upMaskView.frame;
    frame1.size.height +=1;
    _upMaskView.frame = frame1;
    
    if (_sandView.frame.size.height < self.frame.size.height*0.5) {
        CGRect frame2 = _sandView.frame;
        frame2.size.height += 5;
        _sandView.frame = frame2;
    }
    else
    {
        CGRect frame2 = _sandView.frame;
        frame2.size.height += 5;
        _sandView.frame = frame2;
        
        CGRect frame3 = _downMaskView.frame;
        frame3.size.height -=1.5;
        _downMaskView.frame = frame3;
    }
    
    if (_upMaskView.frame.size.height >= self.frame.size.height*0.5) {
        self.timer.fireDate = [NSDate distantFuture];
        [UIView animateWithDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            self.transform = CGAffineTransformIdentity;
            CGRect frame1 = _upMaskView.frame;
            frame1.size.height =0;
            _upMaskView.frame = frame1;
    
            CGRect frame2 = _sandView.frame;
            frame2.size.height = 0;
            _sandView.frame = frame2;
    
            CGRect frame3 = _downMaskView.frame;
            frame3.origin.y = self.frame.size.height*0.5;
            frame3.size.height = self.frame.size.height*0.5;
            _downMaskView.frame = frame3;
            self.timer.fireDate = [NSDate distantPast];
        }];
    }
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(jhResetFrame) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)jh_remove_timer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc{
    //NSLog(@"%s",__FUNCTION__);
}

@end

