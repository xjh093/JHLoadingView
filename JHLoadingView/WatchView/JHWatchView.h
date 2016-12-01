//
//  WatchView.h
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHBaseView.h"

/**
 *表
 */
@interface JHWatchView : JHBaseView

@end

/**
 *表盘
 */
@interface JHDialView : UIView
@end

/**
 *表盘刻度元素
 */
@interface JHDialElement : UIView
@end

/**
 *秒针
 */
@interface JHSecondHandView : UIView
/**
 *@brief 针的颜色
 */
@property(strong,nonatomic)UIColor *handColor;
@end
