//
//  ZKLogModel.h
//  MyProject
//
//  Created by liuzikang on 16/11/16.
//  Copyright © 2016年 wlstock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKLogModel : NSObject
/** 时间戳 */
@property (nonatomic, assign) double timestamp;
/** log */
@property (nonatomic, copy) NSString *log;

+ (instancetype)logWithText:(NSString*)text;

@end
