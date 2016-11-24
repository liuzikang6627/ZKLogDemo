//
//  ZKLog.h
//  MyProject
//
//  Created by liuzikang on 16/11/16.
//  Copyright © 2016年 wlstock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKLog : NSObject

/** 单例初始化:需在窗口初始化好之后调用 */
+ (instancetype)sharedInstance;
/** 输出log日志 */
+ (void)log:(NSString*)format,...;

// 数值修改
/** Log输出窗口上限 */
@property (nonatomic, assign) int logsCountLimit;
/** Log输出窗口字体 */
@property (nonatomic, strong) UIFont *logsFont;
/** Log输出窗口文本颜色 */
@property (nonatomic, strong) UIColor *logsTextColor;
/** Log输出窗口文本颜色(高亮) */
@property (nonatomic, strong) UIColor *logsTextColorHL;
/** Log输出窗口背景颜色 */
@property (nonatomic, strong) UIColor *logsBgColor;

// 操作接口
/** 清空日志 */
+ (void)clear;
/** 显示开关 */
+ (void)show;
+ (void)hide;

@end
