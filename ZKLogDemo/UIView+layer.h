//
//  UIView+layer.h
//  ZKLog-master
//
//  Created by liuzikang on 16/11/18.
//  Copyright © 2016年 MyProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (layer)

/** 添加描边样式 */
- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;

@end
