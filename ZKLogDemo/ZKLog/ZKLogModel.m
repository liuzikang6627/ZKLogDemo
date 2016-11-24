//
//  ZKLogModel.m
//  MyProject
//
//  Created by liuzikang on 16/11/16.
//  Copyright © 2016年 wlstock. All rights reserved.
//

#import "ZKLogModel.h"

@implementation ZKLogModel

+ (instancetype)logWithText:(NSString*)logText
{
    ZKLogModel *logModel = [ZKLogModel new];
    logModel.timestamp = [[NSDate date] timeIntervalSince1970];
    logModel.log = logText;
    return logModel;
}

@end
