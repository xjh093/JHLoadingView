//
//  GearView.h
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "JHBaseView.h"

/**
 *左右双齿轮
 */
@interface JHTwoGearView : JHBaseView
@end


/**
 *齿轮
 */
@interface JHGearView : JHBaseView

- (instancetype)initWithFrame:(CGRect)frame tW:(CGFloat)tW;

@end

/**
 *齿
 */
@interface JHToothView : UIView
@end
