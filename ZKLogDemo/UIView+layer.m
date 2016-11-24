//
//  UIView+layer.m
//  ZKLog-master
//
//  Created by liuzikang on 16/11/18.
//  Copyright © 2016年 MyProject. All rights reserved.
//

#import "UIView+layer.h"

@implementation UIView (layer)

/** 添加描边样式 */
- (void)setCornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(UIColor*)borderColor
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

@end
