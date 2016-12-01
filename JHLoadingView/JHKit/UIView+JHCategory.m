//
//  UIView+JHCategory.m
//  OAdemo
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIView+JHCategory.h"
#import <objc/runtime.h>
#import "JHBaseView.h"
#import "JHWatchView.h"
#import "JHGearView.h"
#import "JHDoubleGearView.h"
#import "JHTaiChiView.h"
#import "JHDoubleCircleView.h"
#import "JHCubeView.h"
#import "JHBambooDragonflyView.h"
#import "JHBallView.h"
#import "JHHourglassView.h"
#import "JHCircleView.h"

#define JH_bdColor_m(jhclass) \
- (jhclass *(^)(id))jh_bdColor{ \
    JHLog(); \
    return ^id(id bdColor){ \
        if([bdColor isKindOfClass:[UIColor class]]){ \
            self.layer.borderColor = [bdColor CGColor]; \
        }else if ([bdColor isKindOfClass:[NSString class]]){ \
            self.layer.borderColor = [[UIColor jhColor:bdColor] CGColor]; \
        } \
        return self; \
    }; \
}

#define JH_bdWidth_m(jhclass) \
- (jhclass *(^)(id))jh_bdWidth{ \
    JHLog(); \
    return ^id(id bdWidth){ \
        if([bdWidth isKindOfClass:[NSNumber class]]){ \
            self.layer.borderWidth = [bdWidth floatValue]; \
        } \
        return self; \
    };\
}

#define JH_cnRadius_m(jhclass) \
- (jhclass *(^)(id))jh_cnRadius{ \
    JHLog(); \
    return ^id(id cnRadius){ \
        if([cnRadius isKindOfClass:[NSNumber class]]){ \
            self.layer.cornerRadius = [cnRadius floatValue]; \
        } \
        return self; \
    }; \
}

#define JH_mtBounds_m(jhclass) \
- (jhclass *(^)(id))jh_mtBounds{ \
    JHLog(); \
    return ^id(id mtBounds){ \
        if([mtBounds isKindOfClass:[NSNumber class]]){ \
            self.layer.masksToBounds = [mtBounds floatValue]; \
        } \
        return self; \
    }; \
}

#define JH_addToView_m(jhclass) \
- (jhclass *(^)(id))jh_addToView{ \
    JHLog(); \
    return ^id(id view){ \
        if ([view isKindOfClass:[UIView class]]) { \
            [view addSubview:self]; \
        } \
        return self; \
    }; \
}

#define JH_tag_m(jhclass) \
- (jhclass *(^)(id))jh_tag{ \
    JHLog(); \
    return ^id(id tag){ \
        if ([tag isKindOfClass:[NSNumber class]]) { \
            self.tag = [tag integerValue]; \
        } \
        return self; \
    }; \
}

#define JH_frame_m(jhclass) \
- (jhclass *(^)(id))jh_frame{ \
    JHLog(); \
    return ^id(id frame){ \
        if ([frame isKindOfClass:[NSValue class]]) { \
            self.frame = [frame CGRectValue]; \
        }else if ([frame isKindOfClass:[NSString class]]){ \
            if ([frame hasPrefix:@"{"]) { \
                self.frame = CGRectFromString(frame); \
            }else if ([frame hasPrefix:@"["]){ \
                self.frame = [self jhRectFromString:frame]; \
            }else{ \
                self.frame = CGRectZero; \
            } \
        } \
        return self; \
    }; \
}

#define JH_bgColor_m(jhclass) \
- (jhclass *(^)(id))jh_bgColor{ \
    JHLog(); \
    return  ^id(id color){ \
        if ([color isKindOfClass:[UIColor class]]) { \
            self.backgroundColor = color; \
        }else if ([color isKindOfClass:[NSString class]]){ \
            self.backgroundColor = [UIColor jhColor:color]; \
        } \
        return self; \
    }; \
}

#define JH_delegate_m(jhclass) \
- (jhclass *(^)(id))jh_delegate{ \
    JHLog(); \
    return ^id(id delegate){ \
        if ([delegate isKindOfClass:[UIViewController class]] || \
            [delegate isKindOfClass:[UIView class]]) { \
            self.delegate = delegate; \
        } \
        return self; \
    }; \
}

#define JH_text_m(jhclass) \
- (jhclass *(^)(id))jh_text{ \
    JHLog(); \
    return ^id(id text){ \
        if ([text isKindOfClass:[NSString class]]) { \
            self.text = text; \
        } \
        return self; \
    }; \
}

#define JH_color_m(jhclass) \
- (jhclass *(^)(id))jh_color{ \
    JHLog(); \
    return ^id(id color){ \
        if ([color isKindOfClass:[UIColor class]]) { \
            self.textColor = color; \
        }else if ([color isKindOfClass:[NSString class]]){ \
            self.textColor = [UIColor jhColor:color]; \
        } \
        return self; \
    }; \
}

#define JH_font_m(jhclass) \
- (jhclass *(^)(id))jh_font{ \
    JHLog(); \
    return ^id(id font){ \
        if ([font isKindOfClass:[UIFont class]]) { \
            self.font = font; \
        }else if ([font isKindOfClass:[NSString class]]){ \
            self.font = [UIFont jhFont:font]; \
        } \
        return self; \
    }; \
}

#define JH_align_m(jhclass) \
- (jhclass *(^)(id))jh_align{ \
    JHLog(); \
    return ^id(id align){ \
        if ([align isKindOfClass:[NSNumber class]]) { \
            self.textAlignment = [align integerValue]; \
        } \
        return self; \
    }; \
}

#define JH_alpha_m(jhclass) \
- (jhclass *(^)(id))jh_alpha{ \
    JHLog(); \
    return ^id(id alpha){ \
        if ([alpha isKindOfClass:[NSNumber class]]) { \
            self.alpha = [alpha floatValue]; \
        } \
        return self; \
    }; \
}

@implementation UIView (JHCategory)

- (void)setJh_x:(CGFloat)jh_x{
    CGRect frame = self.frame;
    frame.origin.x = jh_x;
    self.frame = frame;
}

- (CGFloat)jh_x{
    return self.frame.origin.x;
}

- (void)setJh_y:(CGFloat)jh_y{
    CGRect frame = self.frame;
    frame.origin.y = jh_y;
    self.frame = frame;
}

- (CGFloat)jh_y{
    return self.frame.origin.y;
}

- (void)setJh_w:(CGFloat)jh_w{
    CGRect frame = self.frame;
    frame.size.width = jh_w;
    self.frame = frame;
}

- (CGFloat)jh_w{
    return self.frame.size.width;
}

- (void)setJh_h:(CGFloat)jh_h{
    CGRect frame = self.frame;
    frame.size.height = jh_h;
    self.frame = frame;
}

- (CGFloat)jh_h{
    return self.frame.size.height;
}

- (void)setJh_center_x:(CGFloat)jh_center_x{
    CGPoint point = self.center;
    point.x = jh_center_x;
    self.center = point;
}

- (CGFloat)jh_center_x{
    return self.center.x;
}

- (void)setJh_center_y:(CGFloat)jh_center_y{
    CGPoint point = self.center;
    point.y = jh_center_y;
    self.center = point;
}

- (CGFloat)jh_center_y{
    return self.center.y;
}

- (void)setJh_origin:(CGPoint)jh_origin{
    CGRect frame = self.frame;
    frame.origin.x = jh_origin.x;
    frame.origin.y = jh_origin.y;
    self.frame = frame;
}

- (CGPoint)jh_origin{
    return self.frame.origin;
}

- (void)setJh_size:(CGSize)jh_size{
    CGRect frame = self.frame;
    frame.size.width  = jh_size.width;
    frame.size.height = jh_size.height;
    self.frame = frame;
}

- (CGFloat)jh_max_x{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)jh_max_y{
    return CGRectGetMaxY(self.frame);
}

- (CGSize)jh_size{
    return self.frame.size;
}

JH_tag_m(UIView)
JH_frame_m(UIView)
JH_alpha_m(UIView)
JH_bgColor_m(UIView)
JH_bdColor_m(UIView)
JH_bdWidth_m(UIView)
JH_cnRadius_m(UIView)
JH_mtBounds_m(UIView)
JH_addToView_m(UIView)

+ (UIView *(^)())jh_view{
    return ^id(){
        UIView *view = [[UIView alloc] init];
        return view;
    };
}

- (void)jhAddTapEvent
{
    UITapGestureRecognizer *xTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self addGestureRecognizer:xTap];
}

- (void)hideKeyboard
{
    [self endEditing:YES];
}

- (CGRect)jhRectFromString:(NSString *)frameStr
{
    NSString *saveFrameStr = frameStr;
    if ([frameStr hasPrefix:@"["] && [frameStr hasSuffix:@"]"] && frameStr.length > 3)
    {
        frameStr = [frameStr substringWithRange:NSMakeRange(1, frameStr.length - 2)];
        frameStr = [frameStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSArray *xFourElementArr = [frameStr componentsSeparatedByString:@","];
        if (xFourElementArr.count != 4) return CGRectZero;
        
        NSString *frameString = objc_getAssociatedObject(self, "jhFrameString");
        if (frameString.length == 0) {
            objc_setAssociatedObject(self, "jhFrameString", saveFrameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jhScreenRotate) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        }
        
        CGFloat X = [self jhFloatFromString:xFourElementArr[0]];
        CGFloat Y = [self jhFloatFromString:xFourElementArr[1]];
        CGFloat W = [self jhFloatFromString:xFourElementArr[2]];
        CGFloat H = [self jhFloatFromString:xFourElementArr[3]];
        
        return CGRectMake(X, Y, W, H);
    }
    
    return CGRectZero;
}

- (void)jhScreenRotate
{
    NSString *frameString = objc_getAssociatedObject(self, "jhFrameString");
    if (frameString.length > 0) {
        CGRect frame = [self jhRectFromString:frameString];
        if(!CGRectEqualToRect(CGRectZero, frame)) self.frame = frame;
    }
}

- (CGFloat)jhFloatFromString:(NSString *)string
{
    if ([string hasPrefix:@"x:"] ||
        [string hasPrefix:@"y:"] ||
        [string hasPrefix:@"w:"] ||
        [string hasPrefix:@"h:"])
    {
        NSString *subStr = [string substringFromIndex:2]; //eg. 2_x(100)+10 or x(100)+10 or x(100) or 10
        NSArray  *xArr = [subStr componentsSeparatedByString:@")"];
        //NSLog(@"xArr:%@",xArr);//x(100) 会分割成 x(100 和 ""
        
        if (xArr.count == 1) // 10 针对常量的情况
        {
            NSString *str1 = xArr[0];
            if ([str1 hasPrefix:@"W"]) { //W+10.0,W-10.0,W*10.0,W/10.0,
                CGFloat W = [UIScreen mainScreen].bounds.size.width;
                return [self jhWorH:W str:str1];
            }
            else if ([str1 hasPrefix:@"H"]){
                CGFloat H = [UIScreen mainScreen].bounds.size.height;
                return [self jhWorH:H str:str1];
            }
            else if ([self isPureInt:str1] || [self isPureFloat:str1]) {
                return [str1 floatValue];
            }else{
                return 0.0;
            }
        }
        else if (xArr.count == 2) //2_x(100 +10
        {
            CGFloat firstValue = [self jhParseFirstSubStr:xArr[0]]; // 2_x(100
            
            NSString *secondStr = xArr[1]; // +10
            if (secondStr.length < 2) return firstValue; //只返回前面部分
            
            NSString *subStr1 = [secondStr substringToIndex:1];
            NSString *subStr2 = [secondStr substringFromIndex:1];
            
            if ([self isPureInt:subStr2] ||
                [self isPureFloat:subStr2] ||
                [subStr2 integerValue] != 0 ||
                [subStr2 floatValue] > 0.01)
            {
                CGFloat secondValue = [subStr2 floatValue];
                
                if ([subStr1 isEqualToString:@"+"]) {
                    return firstValue + secondValue;
                }else if ([subStr1 isEqualToString:@"-"]) {
                    return firstValue - secondValue;
                }else if ([subStr1 isEqualToString:@"*"]) {
                    return firstValue * secondValue;
                }else if ([subStr1 isEqualToString:@"/"]) {
                    return firstValue / secondValue;
                }else{
                    return firstValue; //只返回前面部分
                }
            }
            else
            {
                return firstValue; //只返回前面部分
            }
        }
        return 0.0;
    }
    return 0.0;
}

- (CGFloat)jhWorH:(CGFloat)wh str:(NSString *)str1
{
    if (str1.length == 1) {
        return wh;
    }
    else if (str1.length > 2){
        NSString *operation = [str1 substringWithRange:NSMakeRange(1, 1)];
        NSString *value = [str1 substringFromIndex:2];
        if ([self isPureInt:value] || [self isPureFloat:value]) {
            if ([operation isEqualToString:@"+"]) {
                return wh + [value floatValue];
            }else if ([operation isEqualToString:@"-"]) {
                return wh - [value floatValue];
            }else if ([operation isEqualToString:@"*"]) {
                return wh * [value floatValue];
            }else if ([operation isEqualToString:@"/"]) {
                return wh / [value floatValue];
            }
        }
    }
    return 0.0;
}

//判断是否为整形
- (BOOL)isPureInt:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isPureFloat:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (CGFloat)jhParseFirstSubStr:(NSString *)firstStr
{
    NSArray *subArr = [firstStr componentsSeparatedByString:@"("]; // 2_x 100
    if (subArr.count != 2) return 0.0;
    
    NSString *first  = subArr[0];
    NSString *second = subArr[1];
    
    if (![self isPureInt:second]) return 0.0;
    
    UIView *view = [self viewWithTag:[second integerValue]];
    if (view == nil) {
        view = [self.superview viewWithTag:[second integerValue]];
        if (view == nil) return 0.0;
    }
    
    return [self jhFloatFromView:view withPreID:first];
}

- (CGFloat)jhFloatFromView:(UIView *)view withPreID:(NSString *)first
{
    if ([first isEqualToString:@"x"]) {
        return view.jh_x;
    }else if ([first isEqualToString:@"y"]){
        return view.jh_y;
    }else if ([first isEqualToString:@"w"]){
        return view.jh_w;
    }else if ([first isEqualToString:@"h"]){
        return view.jh_h;
    }else if ([first isEqualToString:@"maxx"]){
        return view.jh_max_x;
    }else if ([first isEqualToString:@"maxy"]){
        return view.jh_max_y;
    }else{
        return [self jhMultiple:first view:view];
    }
    return 0.0;
}

- (CGFloat)jhMultiple:(NSString *)prefix view:(UIView *)view
{
    /**< prefix: eg: 2_x,3_x,4_x,...*/
    if ([prefix rangeOfString:@"_"].length == 0) {
        return 0.0;
    }
    
    NSArray *arr = [prefix componentsSeparatedByString:@"_"];
    NSString *first = arr[0];
    if (![self isPureInt:first]) return 0.0;
    
    CGFloat floatValue = [self jhFloatFromView:view withPreID:arr[1]];
    return floatValue/[first integerValue];
}

- (CGSize)jhSizeFromString:(NSString *)sizeStr
{
    if ([sizeStr hasPrefix:@"["] && [sizeStr hasSuffix:@"]"] && sizeStr.length > 3)
    {
        sizeStr = [sizeStr substringWithRange:NSMakeRange(1, sizeStr.length - 2)];
        sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSArray *xTwoElementArr = [sizeStr componentsSeparatedByString:@","];
        if (xTwoElementArr.count != 2) return CGSizeZero;
        
        CGFloat X = [self jhFloatFromString:xTwoElementArr[0]];
        CGFloat Y = [self jhFloatFromString:xTwoElementArr[1]];
        
        return CGSizeMake(X, Y);
    }
    
    return CGSizeZero;
}

@end

@implementation UIColor (JHCategory)
+ (UIColor *)jhColor:(id)object{
    //16进制字符串
    if ([object isKindOfClass:[NSString class]]){
        return [self jhColorWithString:(NSString *)object];
    }
    //UIColor
    else if ([object isKindOfClass:[UIColor class]]){
        return (UIColor *)object;
    }
    
    return [UIColor blackColor];
}

+ (UIColor *)jhColorWithString:(NSString *)string{
    //删除字符串中的空格
    NSString *cString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    //长度是 6 或 8
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]){
        cString = [cString substringFromIndex:2];
    }
    
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6){
        return [UIColor blackColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1.0];
}

@end

@implementation UIFont (JHCategory)
+ (UIFont *)jhFont:(id)object{
    //字符串 例如：17,s17,b17,i17
    if ([object isKindOfClass:[NSString class]]){
        return [self jhFontWithString:(NSString *)object];
    }
    //UIFont
    else if ([object isKindOfClass:[UIFont class]]){
        return (UIFont *)object;
    }
    
    return [UIFont systemFontOfSize:17.0];
}

+ (UIFont *)jhFontWithString:(NSString *)string{
    if ([self isPureInt:string] || [self isPureFloat:string]){
        return [UIFont systemFontOfSize:[string floatValue]];
    }else if ([string hasPrefix:@"s"]){
        if ([self jhFontWithSubstr:string]) {
            return [UIFont systemFontOfSize:[[string substringFromIndex:1] floatValue]];
        }else{
            return [UIFont systemFontOfSize:17.0];
        }
    }else if ([string hasPrefix:@"b"]){
        if ([self jhFontWithSubstr:string]) {
            return [UIFont boldSystemFontOfSize:[[string substringFromIndex:1] floatValue]];
        }else{
            return [UIFont systemFontOfSize:17.0];
        }
    }else if ([string hasPrefix:@"i"]){
        if ([self jhFontWithSubstr:string]) {
            return [UIFont italicSystemFontOfSize:[[string substringFromIndex:1] floatValue]];
        }else{
            return [UIFont systemFontOfSize:17.0];
        }
    }
    
    //默认
    return [UIFont systemFontOfSize:17.0];
}

//判断是否为整形
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)jhFontWithSubstr:(NSString *)string
{
    NSString *subStr = [string substringFromIndex:1];
    if ([self isPureInt:subStr] || [self isPureFloat:subStr]){
        return YES;
    }
    return NO;
}


@end

@implementation UILabel (JHCategory)
+ (UILabel *)jhLabel:(NSString *)frameStr text:(NSString *)text color:(id)color font:(NSString *)font align:(NSString *)align bgColor:(id)bgColor tag:(NSInteger)tag view:(UIView *)view addToView:(BOOL)flag
{
    UILabel *xLabel = [[UILabel alloc] init];
    xLabel.textColor = [UIColor blackColor];
    xLabel.backgroundColor = [UIColor whiteColor];
    
    xLabel.frame = [view jhRectFromString:frameStr];
    xLabel.text = text;
    if(color) xLabel.textColor = [UIColor jhColor:color];
    xLabel.font = [UIFont jhFont:font];
    xLabel.textAlignment = [align integerValue];
    if(bgColor) xLabel.backgroundColor = [UIColor jhColor:bgColor];
    xLabel.tag = tag;
    
    if (view && flag) [view addSubview:xLabel];
    
    return xLabel;
}

+ (UILabel *(^)())jh_label{
    return ^id(){
        UILabel *label = [[UILabel alloc] init];
        return label;
    };
}

JH_tag_m(UILabel)
JH_text_m(UILabel)
JH_font_m(UILabel)
JH_align_m(UILabel)
JH_color_m(UILabel)
JH_frame_m(UILabel)
JH_alpha_m(UILabel)
JH_bgColor_m(UILabel)
JH_bdColor_m(UILabel)
JH_bdWidth_m(UILabel)
JH_cnRadius_m(UILabel)
JH_mtBounds_m(UILabel)
JH_addToView_m(UILabel)

#if 0
- (UILabel *(^)(id))jh_addToView{
    JHLog();
    return ^id(id view){
        if ([view isKindOfClass:[UIView class]]) {
            [view addSubview:self];
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_frame{
    JHLog();
    return ^id(id frame){
        if ([frame isKindOfClass:[NSValue class]]) {
            self.frame = [frame CGRectValue];
        }else if ([frame isKindOfClass:[NSString class]]){
            if ([frame hasPrefix:@"{"]) {
                self.frame = CGRectFromString(frame);
            }else if ([frame hasPrefix:@"["]){
                self.frame = [self jhRectFromString:frame];
            }else{
                self.frame = CGRectZero;
            }
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_bgColor{
    JHLog();
    return  ^id(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            self.backgroundColor = color;
        }else if ([color isKindOfClass:[NSString class]]){
            self.backgroundColor = [UIColor jhColor:color];
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_tag{
    JHLog();
    return ^id(id tag){
        if ([tag isKindOfClass:[NSNumber class]]) {
            self.tag = [tag integerValue];
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_text{
    JHLog();
    return ^id(id text){
        if ([text isKindOfClass:[NSString class]]) {
            self.text = text;
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_color{
    JHLog();
    return ^id(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            self.textColor = color;
        }else if ([color isKindOfClass:[NSString class]]){
            self.textColor = [UIColor jhColor:color];
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_font{
    JHLog();
    return ^id(id font){
        if ([font isKindOfClass:[UIFont class]]) {
            self.font = font;
        }else if ([font isKindOfClass:[NSString class]]){
            self.font = [UIFont jhFont:font];
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_align{
    JHLog();
    return ^id(id align){
        if ([align isKindOfClass:[NSNumber class]]) {
            self.textAlignment = [align integerValue];
        }
        return self;
    };
}

#endif



- (UILabel *(^)(id))jh_lines{
    JHLog();
    return ^id(id lines){
        if ([lines isKindOfClass:[NSNumber class]]) {
            self.numberOfLines = [lines integerValue];
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_adjust{
    JHLog();
    return ^id(id adjust){
        if ([adjust isKindOfClass:[NSNumber class]]) {
            self.adjustsFontSizeToFitWidth = [adjust boolValue];
        }
        return self;
    };
}

@end

@implementation UIImageView (JHCategory)

JH_tag_m(UIImageView)
JH_frame_m(UIImageView)
JH_alpha_m(UIImageView)
JH_bgColor_m(UIImageView)
JH_bdColor_m(UIImageView)
JH_bdWidth_m(UIImageView)
JH_cnRadius_m(UIImageView)
JH_mtBounds_m(UIImageView)
JH_addToView_m(UIImageView)

+ (UIImageView *(^)())jh_imageView{
    return ^id(){
        UIImageView *imageView = [[UIImageView alloc] init];
        return imageView;
    };
}

- (UIImageView *(^)(id))jh_image{
    JHLog();
    return ^id(id image){
        if ([image isKindOfClass:[NSString class]]) {
            self.image = [UIImage imageNamed:image];
        }else if ([image isKindOfClass:[UIImage class]]){
            self.image = image;
        }
        return self;
    };
}

@end

@implementation UITextField (JHCategory)

JH_tag_m(UITextField)
JH_text_m(UITextField)
JH_font_m(UITextField)
JH_align_m(UITextField)
JH_color_m(UITextField)
JH_frame_m(UITextField)
JH_alpha_m(UITextField)
JH_bgColor_m(UITextField)
JH_bdColor_m(UITextField)
JH_bdWidth_m(UITextField)
JH_cnRadius_m(UITextField)
JH_mtBounds_m(UITextField)
JH_delegate_m(UITextField)
JH_addToView_m(UITextField)

+ (UITextField *(^)())jh_textField{
    return ^id(){
        UITextField *textField = [[UITextField alloc] init];
        return textField;
    };
}

- (UITextField *(^)(id))jh_bdStyle{
    JHLog();
    return ^id(id bdStyle){
        if ([bdStyle isKindOfClass:[NSNumber class]]) {
            self.borderStyle = [bdStyle integerValue];
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_pHolder{
    JHLog();
    return ^id(id pHolder){
        if ([pHolder isKindOfClass:[NSString class]]) {
            self.placeholder = pHolder;
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_pHColor{
    JHLog();
    return ^id(id pHColor){
        [self setValue:[UIColor jhColor:pHColor] forKeyPath:@"_placeholderLabel.textColor"];
        return self;
    };
}
- (UITextField *(^)(id))jh_pHFont{
    JHLog();
    return ^id(id pHFont){
        [self setValue:[UIFont jhFont:pHFont] forKeyPath:@"_placeholderLabel.font"];
        return self;
    };
}
- (UITextField *(^)(id))jh_cbMode{
    JHLog();
    return ^id(id cbMode){
        if ([cbMode isKindOfClass:[NSNumber class]]) {
            self.clearButtonMode = [cbMode integerValue];
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_lvMode{
    JHLog();
    return ^id(id lvMode){
        if ([lvMode isKindOfClass:[NSNumber class]]) {
            self.leftViewMode = [lvMode integerValue];
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_rvMode{
    JHLog();
    return ^id(id rvMode){
        if ([rvMode isKindOfClass:[NSNumber class]]) {
            self.rightViewMode = [rvMode integerValue];
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_lfView{
    JHLog();
    return ^id(id lfView){
        if ([lfView isKindOfClass:[UIView class]]) {
            self.leftView = lfView;
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_rtView{
    JHLog();
    return ^id(id rtView){
        if ([rtView isKindOfClass:[UIView class]]) {
            self.rightView = rtView;
        }
        return self;
    };
}



@end

@implementation UITextView (JHCategory)

JH_tag_m(UITextView)
JH_text_m(UITextView)
JH_font_m(UITextView)
JH_align_m(UITextView)
JH_color_m(UITextView)
JH_frame_m(UITextView)
JH_alpha_m(UITextView)
JH_bgColor_m(UITextView)
JH_bdColor_m(UITextView)
JH_bdWidth_m(UITextView)
JH_cnRadius_m(UITextView)
JH_mtBounds_m(UITextView)
JH_delegate_m(UITextView)
JH_addToView_m(UITextView)

+ (UITextView *(^)())jh_textView{
    return ^id(){
        UITextView *textView = [[UITextView alloc] init];
        return textView;
    };
}

@end

@implementation UIButton (JHCategory)
+ (UIButton *)jhButton:(UIButtonType)type frame:(NSString *)frameStr title:(NSString *)title color:(id)color font:(NSString *)font bgColor:(id)bgColor radius:(CGFloat)radius target:(id)target selector:(NSString *)selector tag:(NSInteger)tag view:(UIView *)view addToView:(BOOL)flag
{
    UIButton *xButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (type == 0) xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xButton.backgroundColor = [UIColor lightGrayColor];
    
    xButton.frame = [view jhRectFromString:frameStr];
    xButton.titleLabel.font = [UIFont jhFont:font];
    xButton.layer.cornerRadius = radius;
    xButton.tag = tag;
    
    if(bgColor) xButton.backgroundColor = [UIColor jhColor:bgColor];
    if (title.length > 0) {
        [xButton setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [xButton setTitleColor:[UIColor jhColor:color] forState:UIControlStateNormal];
    }
    if (target && selector.length > 0) {
        [xButton addTarget:target
                    action:NSSelectorFromString(selector)
          forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (view && flag) [view addSubview:xButton];
    
    return xButton;
}



JH_tag_m(UIButton)
JH_frame_m(UIButton)
JH_alpha_m(UIButton)
JH_bgColor_m(UIButton)
JH_bdColor_m(UIButton)
JH_bdWidth_m(UIButton)
JH_cnRadius_m(UIButton)
JH_mtBounds_m(UIButton)
JH_addToView_m(UIButton)

+ (UIButton *(^)(id))jh_button{
    return ^id(id type){
        if ([type isKindOfClass:[NSNumber class]]) {
            UIButton *button = [UIButton buttonWithType:[type integerValue]];
            return button;
        }
        return nil;
    };
}

#if 0
- (UIButton *(^)(id))jh_addToView{
    return ^id(id view){
        if ([view isKindOfClass:[UIView class]]) {
            [view addSubview:self];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_frame{
    JHLog();
    return ^id(id frame){
        if ([frame isKindOfClass:[NSValue class]]) {
            self.frame = [frame CGRectValue];
        }else if ([frame isKindOfClass:[NSString class]]){
            if ([frame hasPrefix:@"{"]) {
                self.frame = CGRectFromString(frame);
            }else if ([frame hasPrefix:@"["]){
                self.frame = [self jhRectFromString:frame];
            }else{
                self.frame = CGRectZero;
            }
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_bgColor{
    JHLog();
    return  ^id(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            self.backgroundColor = color;
        }else if ([color isKindOfClass:[NSString class]]){
            self.backgroundColor = [UIColor jhColor:color];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_tag{
    JHLog();
    return ^id(id tag){
        if ([tag isKindOfClass:[NSNumber class]]) {
            self.tag = [tag integerValue];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_radius{
    JHLog();
    return ^id(id radius){
        if ([radius isKindOfClass:[NSNumber class]]) {
            self.layer.cornerRadius = [radius floatValue];
        }
        return self;
    };
}

#endif

- (UIButton *(^)(id))jh_title{
    JHLog();
    return ^id(id title){
        if ([title isKindOfClass:[NSString class]]) {
            [self setTitle:title forState:UIControlStateNormal];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_color{
    JHLog();
    return ^id(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            [self setTitleColor:color forState:UIControlStateNormal];
        }else if ([color isKindOfClass:[NSString class]]){
            [self setTitleColor:[UIColor jhColor:color] forState:UIControlStateNormal];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_font{
    JHLog();
    return ^id(id font){
        if ([font isKindOfClass:[UIFont class]]) {
            self.titleLabel.font = font;
        }else if ([font isKindOfClass:[NSString class]]){
            self.titleLabel.font = [UIFont jhFont:font];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_image{
    JHLog();
    return ^id(id image){
        if ([image isKindOfClass:[NSString class]]) {
            [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }else if ([image isKindOfClass:[UIImage class]]){
            [self setImage:image forState:UIControlStateNormal];
        }
        return self;
    };
}

- (UIButton *(^)(id,id,id))jh_target_selector_event{
    JHLog();
    return ^id(id target,id selector,id event){
        if (([target isKindOfClass:[UIViewController class]] ||
             [target isKindOfClass:[UIView class]]) &&
            [selector isKindOfClass:[NSString class]] &&
            [event isKindOfClass:[NSNumber class]]) {
            [self addTarget:target action:NSSelectorFromString(selector) forControlEvents:[event unsignedIntegerValue]];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_bgImage{
    JHLog();
    return ^id(id bgImage){
        if ([bgImage isKindOfClass:[NSString class]]) {
            [self setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
        }else if ([bgImage isKindOfClass:[UIImage class]]){
            [self setBackgroundImage:bgImage forState:UIControlStateNormal];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_hTitle{
    JHLog();
    return ^id(id hTitle){
        if ([hTitle isKindOfClass:[NSString class]]) {
            [self setTitle:hTitle forState:UIControlStateHighlighted];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_hColor{
    JHLog();
    return ^id(id hColor){
        if ([hColor isKindOfClass:[UIColor class]]) {
            [self setTitleColor:hColor forState:UIControlStateHighlighted];
        }else if ([hColor isKindOfClass:[NSString class]]){
            [self setTitleColor:[UIColor jhColor:hColor] forState:UIControlStateHighlighted];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_hImage{
    JHLog();
    return ^id(id hImage){
        if ([hImage isKindOfClass:[NSString class]]) {
            [self setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
        }else if ([hImage isKindOfClass:[UIImage class]]){
            [self setImage:hImage forState:UIControlStateHighlighted];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_sTitle{
    JHLog();
    return ^id(id sTitle){
        if ([sTitle isKindOfClass:[NSString class]]) {
            [self setTitle:sTitle forState:UIControlStateSelected];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_sColor{
    JHLog();
    return ^id(id sColor){
        if ([sColor isKindOfClass:[UIColor class]]) {
            [self setTitleColor:sColor forState:UIControlStateSelected];
        }else if ([sColor isKindOfClass:[NSString class]]){
            [self setTitleColor:[UIColor jhColor:sColor] forState:UIControlStateSelected];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_sImage{
    JHLog();
    return ^id(id sImage){
        if ([sImage isKindOfClass:[NSString class]]) {
            [self setImage:[UIImage imageNamed:sImage] forState:UIControlStateSelected];
        }else if ([sImage isKindOfClass:[UIImage class]]){
            [self setImage:sImage forState:UIControlStateSelected];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_tintColor{
    JHLog();
    return ^id(id tintColor){
        if ([tintColor isKindOfClass:[UIColor class]]) {
            self.tintColor = tintColor;
        }else if ([tintColor isKindOfClass:[NSString class]]){
            self.tintColor = [UIColor jhColor:tintColor];
        }
        return self;
    };
}

@end

@implementation UITableView (JHCategory)
+ (UITableView *)jhTableView:(NSString *)frameStr style:(NSInteger)style target:(id)target view:(UIView *)view addToView:(BOOL)flag
{
    UITableView *xTableView = nil;
    if (style == 0 || style == 1)
        xTableView = [[UITableView alloc] initWithFrame:[view jhRectFromString:frameStr] style:style];
    
    xTableView.delegate = target;
    xTableView.dataSource = target;
    xTableView.tableFooterView = [[UIView alloc] init];
    xTableView.showsVerticalScrollIndicator = NO;
    xTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (view && flag) [view addSubview:xTableView];
    
    return xTableView;
}

JH_tag_m(UITableView)
JH_frame_m(UITableView)
JH_alpha_m(UITableView)
JH_bgColor_m(UITableView)
JH_bdColor_m(UITableView)
JH_bdWidth_m(UITableView)
JH_cnRadius_m(UITableView)
JH_mtBounds_m(UITableView)
JH_delegate_m(UITableView)
JH_addToView_m(UITableView)

+ (UITableView *(^)(id))jh_tableView{
    return ^id(id type){
        if ([type isKindOfClass:[NSNumber class]]) {
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[type integerValue]];
            return tableView;
        }
        return nil;
    };
}

@end

@implementation UIScrollView (JHCategory)

JH_tag_m(UIScrollView)
JH_frame_m(UIScrollView)
JH_alpha_m(UIScrollView)
JH_bgColor_m(UIScrollView)
JH_bdColor_m(UIScrollView)
JH_bdWidth_m(UIScrollView)
JH_cnRadius_m(UIScrollView)
JH_mtBounds_m(UIScrollView)
JH_delegate_m(UIScrollView)
JH_addToView_m(UIScrollView)

+ (UIScrollView *(^)())jh_scrollView{
    return ^id(){
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        return scrollView;
    };
}

- (UIScrollView *(^)(id))jh_contentSize{
    JHLog();
    return ^id(id contentSize){
        if ([contentSize isKindOfClass:[NSValue class]]) {
            self.contentSize = [contentSize CGSizeValue];
        }else if ([contentSize isKindOfClass:[NSString class]]){
            if ([contentSize hasPrefix:@"{"]) {
                self.contentSize = CGSizeFromString(contentSize);
            }else if ([contentSize hasPrefix:@"["]){
                self.contentSize = [self jhSizeFromString:contentSize];
            }else{
                self.frame = CGRectZero;
            }
        }
        return self;
    };
}
@end

@implementation UIActivityIndicatorView (JHCategory)
+ (UIActivityIndicatorView *)jhAIViewInsuperView:(UIView *)superView showInfo:(NSString *)text type:(int)type
{
    UIActivityIndicatorView *xAIView = [[UIActivityIndicatorView alloc] init];
    xAIView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;//37 x 37
    xAIView.backgroundColor = [UIColor blackColor];
    xAIView.hidesWhenStopped = YES;
    xAIView.layer.cornerRadius = 5;
    
    CGSize size = CGSizeZero;
    if (text.length > 0){
        size = [self jhAutoSize:text];
    }
    
    CGFloat width = size.width < 80 ? 80 : size.width + 20;
    CGFloat height = size.height > 20 ? 67 + size.height : 87;
    
    //宽度没有超过最大值时，保持 宽 与 高 相等
    if (width < [UIScreen mainScreen].bounds.size.width - 100){
        width = width < height ? height : width;
    }
    
    //高度不超过最大高度
    UIView *tView = nil;
    BOOL flag = NO;
    if (height > [UIScreen mainScreen].bounds.size.height - 150) {
        height = [UIScreen mainScreen].bounds.size.height - 150;
        
        //超过时，添加scrollView
        CGRect frame = CGRectMake(0, 57, width, height - 57);
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.jh_addToView(xAIView).jh_frame(JHFRAME(frame)).jh_contentSize(JHSIZE(CGSizeMake(width, size.height)));
        flag = YES;
        tView = scrollView;
    }else{
        tView = xAIView;
    }
    
    xAIView.frame = CGRectMake(0, 0, width, height);
    
    //NSLog(@"frame:%@",NSStringFromCGRect(xAIView.frame));
    //有显示信息
    if (text.length > 0)
    {
        //调整 控件 位置
        UIView *view = xAIView.subviews[0];
        view.jh_y = 10;
        
        int index = arc4random()%12;
        if (type >= 0 && type <=11) {
            index = type;
        }
        if (index == 0) {
            [self jhAiview:xAIView jhAnimationView:[[JHWatchView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }else if (index == 1) {
            [self jhAiview:xAIView jhAnimationView:[[JHGearView alloc] initWithFrame:CGRectMake(0, 0, 40, 40) tW:5]];
        }else if (index == 2) {
            [self jhAiview:xAIView jhAnimationView:[[JHDoubleGearView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }else if (index == 3) {
            [self jhAiview:xAIView jhAnimationView:[[JHTwoGearView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }else if (index == 4) {
            [self jhAiview:xAIView jhAnimationView:[[JHTaiChiView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }else if (index == 5) {
            [self jhAiview:xAIView jhAnimationView:[[JHDoubleCircleView alloc] initWithFrame:CGRectMake(0, 0, 40, 40) type:1]];
        }else if (index == 6) {
            [self jhAiview:xAIView jhAnimationView:[[JHCubeView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }else if (index == 7) {
            [self jhAiview:xAIView jhAnimationView:[[JHBambooDragonflyView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }else if (index == 8) {
            [self jhAiview:xAIView jhAnimationView:[[JHBallView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }else if (index == 9) {
            [self jhAiview:xAIView jhAnimationView:[[JHHourglassView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }else if (index == 10) {
            [self jhAiview:xAIView jhAnimationView:[[JHDoubleCircleView alloc] initWithFrame:CGRectMake(0, 0, 40, 40) type:2]];
        }else if (index == 11) {
            [self jhAiview:xAIView jhAnimationView:[[JHCircleView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]];
        }

        CGFloat l1Y = CGRectGetMaxY(view.frame) + 10;
        if (flag) {
            l1Y = 0;
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.jh_addToView(tView).jh_frame(JHFRAME(CGRectMake(0, l1Y, width, size.height))).jh_text(text).jh_color([UIColor whiteColor]).jh_lines(@(0)).jh_bgColor([UIColor clearColor]).jh_align(@(1));
    }
    
    xAIView.center = superView.center;
    
    if (superView) {
        [superView addSubview:xAIView];
    }
    return xAIView;
}

+ (void)jhAiview:(UIActivityIndicatorView *)xAIView jhAnimationView:(JHBaseView *)baseView
{
    //调整 控件 位置
    UIView *view = xAIView.subviews[0];
    baseView.center = view.center;
    view.hidden = YES;
    [xAIView addSubview:baseView];
}

+ (CGSize)jhAutoSize:(NSString *)text
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 120;
    
    //单行
    CGSize size1 = CGSizeMake(MAXFLOAT, 20);
    CGFloat width1 = [text boundingRectWithSize:size1 options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.width;
    
    if (width1 <= width)
    {
        return CGSizeMake(width1, 20);
    }
    
    //多行
    CGSize size2 = CGSizeMake(width, MAXFLOAT);
    CGFloat height1 = [text boundingRectWithSize:size2 options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    return CGSizeMake(width, height1);
}

- (void)willMoveToSuperview:(UIView *)superView
{
    if (!superView) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[JHBaseView class]]) {
                [(JHBaseView *)view jh_remove_timer];
            }
        }
    }
}

@end

@implementation UIAlertController (JHCategory)

+ (UIAlertController *(^)(id,id,id))jh_alertCtrl{
    return ^id(id title,id message,id type){
        if ([type integerValue] == 0 || [type integerValue] == 1) {
            UIAlertController *jhAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:[type integerValue]];
            return jhAlert;
        }
        return nil;
    };
}

- (UIAlertController *(^)(id,jhAlertAction))jh_addNormalAction{
    return ^id(id title,jhAlertAction jhBlock){
        UIAlertAction *jhAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            jhBlock();
        }];
        [self addAction:jhAction];
        return self;
    };
}

- (UIAlertController *(^)(id,jhAlertAction))jh_addCancelAction{
    return ^id(id title,jhAlertAction jhBlock){
        UIAlertAction *jhAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            jhBlock();
        }];
        [self addAction:jhAction];
        return self;
    };
}

- (UIAlertController *(^)(id,jhAlertAction))jh_addDestructAction{
    return ^id(id title,jhAlertAction jhBlock){
        UIAlertAction *jhAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            jhBlock();
        }];
        [self addAction:jhAction];
        return self;
    };
}

- (UIAlertController *(^)(id))jh_addTextField{
    return ^id(id title){
        [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = title;
            textField.leftViewMode = UITextFieldViewModeAlways;
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 8)];
        }];
        return self;
    };
}

- (UIAlertController *(^)(id))jh_show{
    return ^id(id vc){
        if ([vc isKindOfClass:[UIViewController class]]) {
            [vc presentViewController:self animated:YES completion:nil];
        }
        return self;
    };
}

@end


@implementation UISwitch (JHCategory)

JH_tag_m(UISwitch)
JH_frame_m(UISwitch)
JH_alpha_m(UISwitch)
JH_bgColor_m(UISwitch)
JH_bdColor_m(UISwitch)
JH_bdWidth_m(UISwitch)
JH_cnRadius_m(UISwitch)
JH_mtBounds_m(UISwitch)
JH_addToView_m(UISwitch)

- (UISwitch *(^)(id))jh_tintColor{
    JHLog();
    return ^id(id tintColor){
        if ([tintColor isKindOfClass:[UIColor class]]) {
            self.tintColor = tintColor;
        }else if ([tintColor isKindOfClass:[NSString class]]){
            self.tintColor = [UIColor jhColor:tintColor];
        }
        return self;
    };
}

- (UISwitch *(^)(id))jh_onTintColor{
    JHLog();
    return ^id(id onTintColor){
        if ([onTintColor isKindOfClass:[UIColor class]]) {
            self.onTintColor = onTintColor;
        }else if ([onTintColor isKindOfClass:[NSString class]]){
            self.onTintColor = [UIColor jhColor:onTintColor];
        }
        return self;
    };
}
- (UISwitch *(^)(id))jh_thTintColor{
    JHLog();
    return ^id(id thTintColor){
        if ([thTintColor isKindOfClass:[UIColor class]]) {
            self.thumbTintColor = thTintColor;
        }else if ([thTintColor isKindOfClass:[NSString class]]){
            self.thumbTintColor = [UIColor jhColor:thTintColor];
        }
        return self;
    };
}
- (UISwitch *(^)(id))jh_onImage{
    JHLog();
    return ^id(id onImage){
        if ([onImage isKindOfClass:[NSString class]]) {
            self.onImage = [UIImage imageNamed:onImage];
        }else if ([onImage isKindOfClass:[UIImage class]]){
            self.onImage = onImage;
        }
        return self;
    };
}
- (UISwitch *(^)(id))jh_offImage{
    JHLog();
    return ^id(id offImage){
        if ([offImage isKindOfClass:[NSString class]]) {
            self.offImage = [UIImage imageNamed:offImage];
        }else if ([offImage isKindOfClass:[UIImage class]]){
            self.offImage = offImage;
        }
        return self;
    };
}

@end

