//
//  ZKLogView.m
//  MyProject
//
//  Created by liuzikang on 16/11/17.
//  Copyright © 2016年 wlstock. All rights reserved.
//

#import "ZKLogView.h"

@implementation ZKLogView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
        
        // baseView -> textView
        CGRect textViewFrame = self.bounds;
        textViewFrame.origin.y += 25;
        textViewFrame.size.height -= 25;
        
        UITextView *textView = [[UITextView alloc]initWithFrame:textViewFrame];
        [textView setBackgroundColor:self.bgColor];
        [textView setTextColor:self.textColor];
        [textView setFont:self.font];
        [textView setEditable:NO];
        [self addSubview:textView];
        self.textView = textView;
    }
    return self;
}

#pragma mark - Get/Set
- (void)setFont:(UIFont *)font
{
    _font = font;
    self.textView.font = font;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textView.textColor = textColor;
}

- (void)setTextColorHL:(UIColor *)textColorHL
{
    _textColorHL = textColorHL;
    self.textView.textColor = textColorHL;
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.textView.backgroundColor = bgColor;
}

@end
