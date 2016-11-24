//
//  ZKLogView.h
//  MyProject
//
//  Created by liuzikang on 16/11/17.
//  Copyright © 2016年 wlstock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKLogView : UIView

/** 输出窗口 */
@property (nonatomic, weak) UITextView *textView;
/** log字体 */
@property (nonatomic, strong) UIFont *font;
/** log颜色 */
@property (nonatomic, strong) UIColor *textColor;
/** log颜色(高亮) */
@property (nonatomic, strong) UIColor *textColorHL;
/** 背景颜色 */
@property (nonatomic, strong) UIColor *bgColor;

@end
