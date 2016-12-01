//
//  UIView+JHCategory.h
//  OAdemo
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#if 0
#define JHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define JHLog(...)
#endif
#else
#define JHLog(...)
#endif

#define JHWEAK(ws) __weak typeof(self) ws = self;

#define JHFRAME(frame) [NSValue valueWithCGRect:frame]
#define JHSIZE(size)   [NSValue valueWithCGSize:size]

#define JH_STRONG_P(jhclass,name) @property (strong, nonatomic) jhclass *name;
#define JH_WEAKLY_P(jhclass,name) @property (weak,   nonatomic) jhclass *name;
#define JH_COPYLY_P(jhclass,name) @property (copy,   nonatomic) jhclass *name;
#define JH_ASSIGN_P(jhclass,name) @property (assign, nonatomic) jhclass  name;
#define JH_BLOCKY_P(block,jhclass,name) @property (copy,nonatomic) void (^block)(jhclass name);

#define JH_bdColor_h(jhclass)     - (jhclass *(^)(id))jh_bdColor;
#define JH_bdWidth_h(jhclass)     - (jhclass *(^)(id))jh_bdWidth;
#define JH_cnRadius_h(jhclass)    - (jhclass *(^)(id))jh_cnRadius;
#define JH_mtBounds_h(jhclass)    - (jhclass *(^)(id))jh_mtBounds;
#define JH_addToView_h(jhclass)   - (jhclass *(^)(id))jh_addToView;
#define JH_frame_h(jhclass)       - (jhclass *(^)(id))jh_frame;
#define JH_bgColor_h(jhclass)     - (jhclass *(^)(id))jh_bgColor;
#define JH_tag_h(jhclass)         - (jhclass *(^)(id))jh_tag;
#define JH_delegate_h(jhclass)    - (jhclass *(^)(id))jh_delegate;
#define JH_text_h(jhclass)        - (jhclass *(^)(id))jh_text;
#define JH_color_h(jhclass)       - (jhclass *(^)(id))jh_color;
#define JH_font_h(jhclass)        - (jhclass *(^)(id))jh_font;
#define JH_align_h(jhclass)       - (jhclass *(^)(id))jh_align;
#define JH_alpha_h(jhclass)       - (jhclass *(^)(id))jh_alpha;

@interface UIView (JHCategory)
@property (assign, nonatomic) CGFloat jh_x;                 /**< 原点x*/
@property (assign, nonatomic) CGFloat jh_y;                 /**< 原点y*/
@property (assign, nonatomic) CGFloat jh_w;                 /**< 宽度w*/
@property (assign, nonatomic) CGFloat jh_h;                 /**< 高度h*/

@property (assign, nonatomic) CGFloat jh_center_x;          /**< 中心点x*/
@property (assign, nonatomic) CGFloat jh_center_y;          /**< 中心点y*/

@property (assign, nonatomic) CGPoint jh_origin;            /**< 原点*/
@property (assign, nonatomic) CGSize  jh_size;              /**< 大小*/

@property (assign, nonatomic, readonly) CGFloat jh_max_x;   /**< 原点x + 宽度w*/
@property (assign, nonatomic, readonly) CGFloat jh_max_y;   /**< 原点y + 宽度h*/

JH_tag_h(UIView)
JH_frame_h(UIView)
JH_alpha_h(UIView)
JH_bgColor_h(UIView)
JH_bdColor_h(UIView)
JH_bdWidth_h(UIView)
JH_cnRadius_h(UIView)
JH_mtBounds_h(UIView)
JH_addToView_h(UIView)

+ (UIView *(^)())jh_view;
#define jhView() jh_view()

- (CGRect)jhRectFromString:(NSString *)frameStr;  /**< frameStr:[x:value,y:value,w:value,h:value] */
- (void)jhAddTapEvent; /**< 添加单击收回键盘事件*/
@end

@interface UIColor (JHCategory)
+ (UIColor *)jhColor:(id)object;
@end

@interface UIFont (JHCategory)
+ (UIFont *)jhFont:(id)object;
@end

@interface UILabel (JHCategory)
+ (UILabel *)jhLabel:(NSString *)frameStr text:(NSString *)text color:(id)color font:(NSString *)font align:(NSString *)align bgColor:(id)bgColor tag:(NSInteger)tag view:(UIView *)view addToView:(BOOL)flag; /**< color:str or obj,default is black, alin:0-left,1-center,2-right bgColor:str or obj,default is white, view:self.view*/

JH_tag_h(UILabel)
JH_text_h(UILabel)
JH_font_h(UILabel)
JH_align_h(UILabel)
JH_color_h(UILabel)
JH_frame_h(UILabel)
JH_alpha_h(UILabel)
JH_bgColor_h(UILabel)
JH_bdColor_h(UILabel)
JH_bdWidth_h(UILabel)
JH_cnRadius_h(UILabel)
JH_mtBounds_h(UILabel)
JH_addToView_h(UILabel)

+ (UILabel *(^)())jh_label;
#define jhLabel() jh_label()

- (UILabel *(^)(id))jh_lines;     /**< NSNumber */
- (UILabel *(^)(id))jh_adjust;    /**< NSNumber @(YES),@(NO)*/
@end

@interface UIImageView (JHCategory)

JH_tag_h(UIImageView)
JH_frame_h(UIImageView)
JH_alpha_h(UIImageView)
JH_bgColor_h(UIImageView)
JH_bdColor_h(UIImageView)
JH_bdWidth_h(UIImageView)
JH_cnRadius_h(UIImageView)
JH_mtBounds_h(UIImageView)
JH_addToView_h(UIImageView)

+ (UIImageView *(^)())jh_imageView;
#define jhImageView() jh_imageView()

- (UIImageView *(^)(id))jh_image;   /**< NSString or UIImage */

@end

@interface UITextField (JHCategory)

JH_tag_h(UITextField)
JH_text_h(UITextField)
JH_font_h(UITextField)
JH_align_h(UITextField)
JH_color_h(UITextField)
JH_frame_h(UITextField)
JH_alpha_h(UITextField)
JH_bgColor_h(UITextField)
JH_bdColor_h(UITextField)
JH_bdWidth_h(UITextField)
JH_cnRadius_h(UITextField)
JH_mtBounds_h(UITextField)
JH_delegate_h(UITextField)
JH_addToView_h(UITextField)

+ (UITextField *(^)())jh_textField;
#define jhTextField() jh_textField()

- (UITextField *(^)(id))jh_bdStyle;
- (UITextField *(^)(id))jh_pHolder;
- (UITextField *(^)(id))jh_pHColor;
- (UITextField *(^)(id))jh_pHFont;
- (UITextField *(^)(id))jh_cbMode;
- (UITextField *(^)(id))jh_lvMode;
- (UITextField *(^)(id))jh_rvMode;
- (UITextField *(^)(id))jh_lfView;
- (UITextField *(^)(id))jh_rtView;

@end

@interface UITextView (JHCategory)

JH_tag_h(UITextView)
JH_text_h(UITextView)
JH_font_h(UITextView)
JH_align_h(UITextView)
JH_color_h(UITextView)
JH_frame_h(UITextView)
JH_alpha_h(UITextView)
JH_bgColor_h(UITextView)
JH_bdColor_h(UITextView)
JH_bdWidth_h(UITextView)
JH_cnRadius_h(UITextView)
JH_mtBounds_h(UITextView)
JH_delegate_h(UITextView)
JH_addToView_h(UITextView)

+ (UITextView *(^)())jh_textView;
#define jhTextView() jh_textView()

@end

@interface UIButton (JHCategory)
+ (UIButton *)jhButton:(UIButtonType)type frame:(NSString *)frameStr title:(NSString *)title color:(id)color font:(NSString *)font bgColor:(id)bgColor radius:(CGFloat)radius target:(id)target selector:(NSString *)selector tag:(NSInteger)tag view:(UIView *)view addToView:(BOOL)flag; /**< type:default is 1,custom-0,system-1.*/

JH_tag_h(UIButton)
JH_frame_h(UIButton)
JH_alpha_h(UIButton)
JH_bgColor_h(UIButton)
JH_bdColor_h(UIButton)
JH_bdWidth_h(UIButton)
JH_cnRadius_h(UIButton)
JH_mtBounds_h(UIButton)
JH_addToView_h(UIButton)

+ (UIButton *(^)(id))jh_button;
#define jhButton(type) jh_button(type)

- (UIButton *(^)(id))jh_title;
- (UIButton *(^)(id))jh_color;
- (UIButton *(^)(id))jh_font;
- (UIButton *(^)(id))jh_image;
- (UIButton *(^)(id,id,id))jh_target_selector_event;
- (UIButton *(^)(id))jh_bgImage;
- (UIButton *(^)(id))jh_hTitle;
- (UIButton *(^)(id))jh_hColor;
- (UIButton *(^)(id))jh_hImage;
- (UIButton *(^)(id))jh_sTitle;
- (UIButton *(^)(id))jh_sColor;
- (UIButton *(^)(id))jh_sImage;
- (UIButton *(^)(id))jh_tintColor;
@end

@interface UITableView (JHCategory)
+ (UITableView *)jhTableView:(NSString *)frameStr style:(NSInteger)style target:(id)target view:(UIView *)view addToView:(BOOL)flag; /**< style:plain-0,group-1.*/

JH_tag_h(UITableView)
JH_frame_h(UITableView)
JH_alpha_h(UITableView)
JH_bgColor_h(UITableView)
JH_bdColor_h(UITableView)
JH_bdWidth_h(UITableView)
JH_cnRadius_h(UITableView)
JH_mtBounds_h(UITableView)
JH_delegate_h(UITableView)
JH_addToView_h(UITableView)

+ (UITableView *(^)(id))jh_tableView;
#define jhTableView(type) jh_tableView(type)

@end

@interface UIScrollView (JHCategory)

JH_tag_h(UIScrollView)
JH_frame_h(UIScrollView)
JH_alpha_h(UIScrollView)
JH_bgColor_h(UIScrollView)
JH_bdColor_h(UIScrollView)
JH_bdWidth_h(UIScrollView)
JH_cnRadius_h(UIScrollView)
JH_mtBounds_h(UIScrollView)
JH_delegate_h(UIScrollView)
JH_addToView_h(UIScrollView)

+ (UIScrollView *(^)())jh_scrollView;
#define jhScrollView() jh_scrollView()

- (UIScrollView *(^)(id))jh_contentSize;

@end

@interface UIActivityIndicatorView (JHCategory)
+ (UIActivityIndicatorView *)jhAIViewInsuperView:(UIView *)view showInfo:(NSString *)text type:(int)type;
@end

typedef void(^jhAlertAction)();
@interface UIAlertController (JHCategory)

+ (UIAlertController *(^)(id,id,id))jh_alertCtrl;
- (UIAlertController *(^)(id,jhAlertAction))jh_addNormalAction;
- (UIAlertController *(^)(id,jhAlertAction))jh_addCancelAction;
- (UIAlertController *(^)(id,jhAlertAction))jh_addDestructAction;
- (UIAlertController *(^)(id))jh_addTextField;
- (UIAlertController *(^)(id))jh_show;

@end

#define jhAlertCtrl(title,message,type)     jh_alertCtrl(title,message,type)

@interface UISwitch (JHCategory)

JH_tag_h(UISwitch)
JH_frame_h(UISwitch)
JH_alpha_h(UISwitch)
JH_bgColor_h(UISwitch)
JH_bdColor_h(UISwitch)
JH_bdWidth_h(UISwitch)
JH_cnRadius_h(UISwitch)
JH_mtBounds_h(UISwitch)
JH_addToView_h(UISwitch)

- (UISwitch *(^)(id))jh_tintColor;
- (UISwitch *(^)(id))jh_onTintColor;
- (UISwitch *(^)(id))jh_thTintColor;
- (UISwitch *(^)(id))jh_onImage;
- (UISwitch *(^)(id))jh_offImage;

@end

