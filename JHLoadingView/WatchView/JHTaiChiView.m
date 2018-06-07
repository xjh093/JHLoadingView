//
//  JHTaiChiView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHTaiChiView.h"

@interface JHTaiChiView()
@property (strong,  nonatomic) NSTimer      *timer;
@property (assign,  nonatomic) double        angle;
@end

@implementation JHTaiChiView

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
    self.layer.cornerRadius = frame.size.width*0.5;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 2;
    self.layer.masksToBounds = YES;

    CGRect lframe = CGRectMake(0, 0, frame.size.width*0.5, frame.size.height);
    JHLeftView *leftView = [[JHLeftView alloc] initWithFrame:lframe];

    CGRect rframe = CGRectMake(frame.size.width*0.5, 0, frame.size.width*0.5, frame.size.height);
    JHRightView *rightView = [[JHRightView alloc] initWithFrame:rframe];
    
    [self addSubview:leftView];
    [self addSubview:rightView];
    
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
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.015 target:self selector:@selector(jhAnimate) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end

@implementation JHLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *color = [UIColor whiteColor];
    //半圆1
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextAddArc(context, 20, 11, 3, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    //半圆2
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextAddArc(context, 21, 29, 9, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    //半圆3
    color = [UIColor blackColor];
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextAddArc(context, 20, 29, 3, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
}

@end


@implementation JHRightView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *color = [UIColor blackColor];
    //半圆1
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextAddArc(context, 0, 11, 9, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    //半圆2
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextAddArc(context, 0, 29, 3, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    color = [UIColor whiteColor];
    //半圆3
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextAddArc(context, 0, 11, 3, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
}

@end



