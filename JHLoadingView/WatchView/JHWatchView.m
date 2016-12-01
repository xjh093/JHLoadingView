//
//  WatchView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHWatchView.h"

@interface JHWatchView ()
@property(strong,nonatomic)JHSecondHandView *hourView;
@property(strong,nonatomic)JHSecondHandView *minuteView;
@property(strong,nonatomic)JHSecondHandView *secondView;
@property(assign,nonatomic)CGFloat hourAngle;
@property(assign,nonatomic)CGFloat minuteAngle;
@property(assign,nonatomic)CGFloat secondAngle;
@property(strong,nonatomic)NSTimer *timer;
@end
@implementation JHWatchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame];
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = frame.size.width/2;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];

    [self initDialView:frame];
    [self initSecondView:frame];
    [self setSecondHandAngle];
    [self fireTheTimer];
}

#pragma mark - 表盘
- (void)initDialView:(CGRect)frame
{
    JHDialView *dialView = [[JHDialView alloc]
                            initWithFrame:CGRectMake(self.layer.borderWidth,
                                                     self.layer.borderWidth,
                                                     frame.size.width - 4,
                                                     frame.size.height - 4)];
    [self addSubview:dialView];
}

#pragma mark - 时针、分针、秒针
- (void)initSecondView:(CGRect)frame
{
    NSArray *colorArray = @[[UIColor blueColor],[UIColor greenColor],[UIColor redColor]];
    NSMutableArray *handViewArray = [NSMutableArray array];
    for (int i = 0; i < colorArray.count; i++)
    {
        JHSecondHandView *handView = [[JHSecondHandView alloc]
                                      initWithFrame:CGRectMake(frame.size.width/2 - self.layer.borderWidth*0.5,
                                                               6,
                                                               self.layer.borderWidth,
                                                               frame.size.height - 12)];
        
        handView.handColor = colorArray[i];
        [handViewArray addObject:handView];
        [self addSubview:handView];
    }
    
    _hourView = handViewArray[0];   //时针
    _minuteView = handViewArray[1]; //分针
    _secondView = handViewArray[2]; //秒针
}

#pragma mark - 设置时针、分针、秒针的角度
- (void)setSecondHandAngle
{
    //+1是因为定时器取的数据是前1秒的
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString *timeString = [formatter stringFromDate:date];
    NSArray *array = [timeString componentsSeparatedByString:@":"];
    
    NSString *hours = array[0];
    NSString *minutes = array[1];
    NSString *seconds = array[2];
    
    _hourAngle = hours.intValue * (M_PI/180*6*5);
    _minuteAngle = minutes.intValue * (M_PI/180*6);
    _secondAngle = seconds.intValue * (M_PI/180*6);
    
    while (_hourAngle > 6.283185)
    {
        _hourAngle -= 6.283185;
    }
    //NSLog(@"%@-%f",hours,_hourAngle);
    //NSLog(@"%@-%f",minutes,_minuteAngle);
    //NSLog(@"%@-%f",seconds,_secondAngle);
    
    //分针走一圈-360度，时针走30度
    //分钟走一格-6度，时针走0.5度
    _hourAngle += minutes.intValue*(M_PI/180/2);
    //NSLog(@"%@-%f",hours,_hourAngle);
    
    _hourView.transform = CGAffineTransformMakeRotation(_hourAngle);
    _minuteView.transform = CGAffineTransformMakeRotation(_minuteAngle);
    _secondView.transform = CGAffineTransformMakeRotation(_secondAngle);
}

#pragma mark - 启动定时器
- (void)fireTheTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                      target:self
                                                    selector:@selector(resetSecondAngle)
                                                    userInfo:nil
                                                     repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [self.timer fire];
}

#pragma mark - 重置秒针的角度
- (void)resetSecondAngle
{
    [UIView animateWithDuration:0.1 animations:^{
        _secondView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        _secondView.transform = CGAffineTransformMakeRotation(_secondAngle);
    }];
    if (_secondAngle >= 6.283185)
    {
        //_secondAngle+=M_PI/180*6;
        _secondAngle = M_PI_2;
        [self resetMinuteAngle];
    }
    else
    {
        //_secondAngle+=M_PI/180*6;
        _secondAngle += M_PI_2;
    }
    
    /**
     *秒针走一圈-360度，分针走6度
     *分针走一圈-360度，时针走30度
     *秒:分:时 = 360:6:0.5 = 720:12:1
     *秒针走1度-M_PI/180 : 1:12/720:1/720
     */
}

#pragma mark - 重置分针的角度
- (void)resetMinuteAngle
{
    if (_minuteAngle >= 6.283185)
    {
        _minuteAngle = M_PI/180*6;
    }
    else
    {
        _minuteAngle +=M_PI/180*6;
    }
    [UIView animateWithDuration:0.7 animations:^{
        _minuteView.transform = CGAffineTransformMakeRotation(_minuteAngle);
    }];
    
    [self resetHourAngle];
}

#pragma mark - 重置时针的角度
- (void)resetHourAngle
{
    if (_hourAngle >= 6.283185)
    {
        _hourAngle = M_PI/180*6/12;
    }
    else
    {
        //1度=M_PI/180
        //分针走一圈-360度，时针走30度
        //分钟走一格-6度，时针走0.5度, 6:0.5 = 60:5 = 12 : 1
        _hourAngle +=M_PI/180*6/12;
    }
    [UIView animateWithDuration:0.7 animations:^{
        _hourView.transform = CGAffineTransformMakeRotation(_hourAngle);
    }];
    
    //NSLog(@"h-%f",_hourAngle);
    //NSLog(@"m-%f",_minuteAngle);
    //NSLog(@"s-%f",_secondAngle);
}

- (void)jh_remove_timer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc{
    //NSLog(@"%s",__FUNCTION__);
}

@end


@implementation JHDialView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame];
        [self initNumber:frame]; //表盘数字 3,6,9,12
    }
    return self;
}

#pragma mark - 表盘刻度
- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat angle = 0;
    for (int i = 0; i < 30; i++)
    {
        if (0 == i%5) {
            JHDialElement *element = [[JHDialElement alloc]
                                      initWithFrame:CGRectMake(frame.size.width/2 - frame.origin.x*0.5,
                                                               0,
                                                               frame.origin.x,
                                                               frame.size.height)];
            element.transform = CGAffineTransformMakeRotation(angle);
            [self addSubview:element];
        }
        angle+=M_PI/180*6;
    }
}

#pragma mark - 表盘数字
- (void)initNumber:(CGRect)frame
{
    CGFloat width = 10;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(0, 0, width, width);
    label1.text = @"12";
    label1.center = CGPointMake(frame.size.width/2, 10);
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0, 0, width, width);
    label2.text = @"3";
    label2.center = CGPointMake(frame.size.width - width*0.7, frame.size.height/2+1);
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(0, 0, width, width);
    label3.text = @"6";
    label3.center = CGPointMake(frame.size.width/2, frame.size.height - 8);
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(0, 0, width, width);
    label4.text = @"9";
    label4.center = CGPointMake(width*0.7, frame.size.height/2+1);
    
    label1.font = label2.font = label3.font = label4.font = [UIFont systemFontOfSize:8];
    label1.textColor = label2.textColor = label3.textColor = label4.textColor = [UIColor whiteColor];
    label1.textAlignment = label2.textAlignment = label3.textAlignment = label4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    [self addSubview:label4];
}

@end



#define height1 2
#define height2 1

@implementation JHDialElement

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


#define WIDTH 4

@interface JHSecondHandView ()
@property(strong,nonatomic)UIView *handView;
@property(strong,nonatomic)UIView *centerView;
@end

@implementation JHSecondHandView

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
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,
                            0,
                            frame.size.width,
                            frame.size.height/2);
    view.backgroundColor = [UIColor redColor];
    _handView = view;
    [self addSubview:view];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.frame = CGRectMake(view.frame.origin.x - WIDTH + view.frame.size.width/2,
                                  view.frame.size.height - WIDTH,
                                  2*WIDTH,
                                  2*WIDTH);
    centerView.backgroundColor = view.backgroundColor;
    _centerView = centerView;
    centerView.layer.masksToBounds = YES;
    centerView.layer.cornerRadius = WIDTH;
    [self addSubview:centerView];
}

- (void)setHandColor:(UIColor *)handColor
{
    if (handColor != nil)
    {
        _handView.backgroundColor = handColor;
        _centerView.backgroundColor = handColor;
    }
    else
    {
        _handView.backgroundColor = [UIColor redColor];
        _centerView.backgroundColor = [UIColor redColor];
    }
}

@end
