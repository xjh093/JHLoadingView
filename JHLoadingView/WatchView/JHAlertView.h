//
//  JHAlertView.h
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface JHAlertView : UIWindow

+ (instancetype)alertView;

- (void)jhShow:(id)info;
- (void)jhHide;

@end

