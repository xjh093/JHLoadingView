//
//  JHAlertView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHAlertView.h"
#import "UIView+JHCategory.h"

@implementation JHAlertView

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
    self.windowLevel = UIWindowLevelAlert;
#if 0
    UIView *view = [[UIView alloc] init];
    view.frame = [UIScreen mainScreen].bounds;
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [self addSubview:view];
#endif
}

+ (instancetype)alertView
{
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)jhShow:(id)info
{
    NSString *msg = @"";
    
    //NSError
    if ([info isKindOfClass:[NSError class]]) {
        NSError *error = (NSError *)info;
        NSDictionary *dic = error.userInfo;
        
        if (dic.count > 0) {
            msg = [NSString stringWithFormat:@"%@:%@",dic.allKeys[0],dic.allValues[0]];
            
        }

    }

    //NSString
    if ([info isKindOfClass:[NSString class]]) {
        msg = info;
    }
    
    
    if (msg.length > 0) {
        UIActivityIndicatorView *aiView = [UIActivityIndicatorView jhAIViewInsuperView:self showInfo:msg type:3];
        [aiView startAnimating];
        
        [self makeKeyAndVisible];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [aiView stopAnimating];
            [self jhHide];
        });
    }
}

- (void)jhHide
{
    [self resignKeyWindow];
}

@end

