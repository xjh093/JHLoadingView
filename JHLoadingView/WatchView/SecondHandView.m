//
//  SecondHandView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "SecondHandView.h"

#define WIDTH 4

@interface SecondHandView ()
@property(strong,nonatomic)UIView *handView;
@property(strong,nonatomic)UIView *centerView;
@end

@implementation SecondHandView

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
