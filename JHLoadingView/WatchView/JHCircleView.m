//
//  JHCircleView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHCircleView.h"

@interface JHCircleView()

@property (assign,  nonatomic) CGFloat       startAngle;
@property (assign,  nonatomic) CGFloat       endAngle;
@property (assign,  nonatomic) BOOL          flag;

@property (strong,  nonatomic) NSTimer      *timer;

@end

@implementation JHCircleView

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
    _startAngle = -M_PI_4;
    _endAngle = -M_PI_2;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    //以20为半径围绕圆心画指定角度扇形
    CGFloat X = rect.size.width*0.5;
    CGFloat Y = rect.size.height*0.5;
    CGContextMoveToPoint(context, X, Y);
    CGContextAddArc(context, X, Y, X, _startAngle, _endAngle, -1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
}

- (void)jhReDraw
{
    if (!_flag) {
        _startAngle += (M_PI / 180)*10;
        _endAngle   += (M_PI / 180)*5;
        
        if (_startAngle >= 3*M_PI) {
            _flag = YES;
        }
    }else{
        _startAngle -= (M_PI / 180)*10;
        _endAngle   -= (M_PI / 180)*5;
        
        if (_startAngle <= -M_PI_2) {
            _flag = NO;
        }
    }
    
    [self setNeedsDisplay];
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(jhReDraw) userInfo:nil repeats:YES];
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

