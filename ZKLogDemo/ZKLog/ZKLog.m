//
//  ZKLog.m
//  MyProject
//
//  Created by liuzikang on 16/11/16.
//  Copyright © 2016年 wlstock. All rights reserved.
//

#import "ZKLog.h"
#import "ZKLogModel.h"
#import "ZKLogView.h"

@interface ZKLog ()
{
    /** frame */
    CGFloat _logWidth, _logHeight, _logX, _logY;
    CGFloat _btnWidth, _btnHeight, _btnX, _btnY;
    /** Log日志数组 */
    NSMutableArray *_logs;
}
/** logView */
@property (nonatomic, weak) ZKLogView *logView;
/** actionBtn */
@property (nonatomic, weak) UIButton *actionBtn;

@end

@implementation ZKLog

+ (instancetype)sharedInstance
{
#if DEBUG   // 只有DEBUG状态才显示
    // 单例模式
    static ZKLog *log = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        log = [ZKLog new];
    });
    return log;
#else
    return nil;
#endif
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _logs = [NSMutableArray array];
        _logsFont = [UIFont systemFontOfSize:10];
        _logsTextColor = [UIColor whiteColor];
        _logsTextColorHL = [UIColor yellowColor];
        _logsBgColor = [UIColor clearColor];
        _logsCountLimit = 100;
        _logWidth = [[UIScreen mainScreen] bounds].size.width;
        _logHeight = 200+5;
        _logX = 0;
        _logY = 20;
        _btnWidth = _logWidth/3;
        _btnHeight = 20;
        _btnX = (_logWidth-_btnWidth)/2;
        _btnY = _logY;
        
        [self setupContent];
    }
    return self;
}

#pragma mark - MainSetting
- (void)setupContent
{
    // 把Log添加到主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // logView
    CGRect logFrame = CGRectMake(_logX, _logY, _logWidth, _logHeight);
    ZKLogView *logView = [[ZKLogView alloc]initWithFrame:logFrame];
    logView.font = _logsFont;
    logView.textColor = _logsTextColor;
    logView.textColorHL = _logsTextColorHL;
    logView.bgColor = _logsBgColor;
    [keyWindow addSubview:logView];
    self.logView = logView;
    
    // actionBtn
    CGRect actionBtnFrame = CGRectMake(_btnX, _btnY, _btnWidth, _btnHeight);
    UIButton *actionBtn = [self buttonWithFrame:actionBtnFrame
                                     titleColor:[UIColor whiteColor]
                                          title:@""];
    [actionBtn setTitle:@"Show Console"
               forState:UIControlStateNormal];
    [actionBtn setTitleColor:[UIColor blackColor]
                    forState:UIControlStateNormal];
    [actionBtn setTitle:@"close"
               forState:UIControlStateSelected];
    [actionBtn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateSelected];
    [actionBtn setSelected:NO];
    [actionBtn addTarget:self action:@selector(onCLickActionBtn:)
                    forControlEvents:UIControlEventTouchUpInside];
    [keyWindow addSubview:actionBtn];
    self.actionBtn = actionBtn;
    
    // logView -> clearBtn
    CGRect clearBtnFrame = CGRectMake(_btnX+_btnWidth+5, _btnY-_logY, 45, _btnHeight);
    UIColor *titleColor = [UIColor whiteColor];
    UIButton *clearBtn = [self buttonWithFrame:clearBtnFrame
                                    titleColor:titleColor
                                         title:@"clear"];
    [clearBtn addTarget:self action:@selector(clear)
               forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:clearBtn];
    
    // 设置默认值
    [self hide];
}

#pragma mark - 接口方法
+ (void)show
{
#if DEBUG
    [[ZKLog sharedInstance] show];
#endif
}

+ (void)hide
{
#if DEBUG
    [[ZKLog sharedInstance] hide];
#endif
}

+ (void)log:(NSString*)format,...
{
#if DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSString *text = [[NSString alloc]initWithFormat:format arguments:argptr];
    va_end(argptr);
    
    NSLog(@"%@", text);
    [[ZKLog sharedInstance] log:text];
//    [[ZKLog sharedInstance] show];
#endif
}

+ (void)clear
{
#if DEBUG
    [[ZKLog sharedInstance] clear];
#endif
}

#pragma mark - 私有方法
- (void)show
{
    [self.logView setHidden:NO];
    [self.logView setUserInteractionEnabled:YES];
    
    [self.actionBtn setSelected:YES];
    [self.actionBtn setBackgroundColor:[UIColor clearColor]];
    [self.actionBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
}

- (void)hide
{
    [self.logView setHidden:YES];
    [self.logView setUserInteractionEnabled:NO];
    
    [self.actionBtn setSelected:NO];
    [self.actionBtn setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.7]];
    [self.actionBtn.layer setBorderColor:[UIColor blackColor].CGColor];
}

- (void)log:(NSString*)newLog
{
    if (!newLog.length) {
        return;
    }
    
    @synchronized (self)
    {
        newLog = [NSString stringWithFormat:@">> [%@] %@\n", [self localDate], newLog]; // 换行
        ZKLogModel *logModel = [ZKLogModel logWithText:newLog];
        
        [_logs addObject:logModel];
        if (_logs.count > _logsCountLimit) {
            [_logs removeObjectAtIndex:0];
        }
        
        [self refreshLogDisplay];
    }
}

- (void)clear
{
    self.logView.textView.text = @"";
    _logs = [NSMutableArray array];
}

#pragma mark - ClickEvent
- (void)onCLickActionBtn:(UIButton*)button
{
    !button.selected ? [self show] : [self hide];
}

#pragma mark - Get/Set
- (void)setLogsFont:(UIFont *)logsFont
{
    _logsFont = logsFont;
    self.logView.font = logsFont;
}

- (void)setLogsTextColor:(UIColor *)logsTextColor
{
    _logsTextColor = logsTextColor;
    self.logView.textColor = logsTextColor;
}

- (void)setLogsTextColorHL:(UIColor *)logsTextColorHL
{
    _logsTextColorHL = logsTextColorHL;
    self.logView.textColorHL = logsTextColorHL;
}

- (void)setLogsBgColor:(UIColor *)logsBgColor
{
    _logsBgColor = logsBgColor;
    self.logView.bgColor = logsBgColor;
}

#pragma mark - Func
/** 刷新Log数据 */
- (void)refreshLogDisplay
{
    NSMutableAttributedString* attributedString = [NSMutableAttributedString new];
    
    double currentTimestamp = [[NSDate date] timeIntervalSince1970];
    for (ZKLogModel* logModel in _logs)
    {
        if (!logModel.log.length) {
            return;
        }
        
        NSMutableAttributedString* logString = [[NSMutableAttributedString alloc] initWithString:logModel.log];
        UIColor* logColor = (currentTimestamp - logModel.timestamp) > 0.1 ? _logsTextColor : _logsTextColorHL; // 新建为yellow, 超过0.1s为white
        [logString addAttribute:NSForegroundColorAttributeName value:logColor range:NSMakeRange(0, logString.length)];
        
        [attributedString appendAttributedString:logString];
    }
    
    self.logView.textView.attributedText = attributedString;
    
    // 自动滚到底部
    if(attributedString.length > 0)
    {
        NSRange bottom = NSMakeRange(attributedString.length - 1, 1);
        [self.logView.textView scrollRangeToVisible:bottom];
    }
}

/** 创建UIButton描边样式 */
- (UIButton*)buttonWithFrame:(CGRect)frame titleColor:(UIColor*)titleColor title:(NSString*)title
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:6.0f];
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor:titleColor.CGColor];
    return button;
}

/** 获取当前时间 */
- (NSString*)localDate
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}

@end
