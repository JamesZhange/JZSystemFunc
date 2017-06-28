//
//  JZDateHelper.h
//  AirDefender
//
//  Created by Liu Rui on 2017/5/18.
//  Copyright © 2017年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JZIntervalDateComponents;




@interface JZDateHelper : NSObject

// 数值<->NSDate 时间戳
+(unsigned long)NowTimeStampSecond;
+(unsigned long)NowTimeStampMillisecond;
+(unsigned long)NowTimeStampMicrosecond;

+(unsigned long)timeStampSecondFromDate: (NSDate*)date;
+(unsigned long)timeStampMillisecondFromDate: (NSDate*)date;
+(unsigned long)timeStampMicrosecondFromDate: (NSDate*)date;

+(NSDate*)dateFromTimeStampSecond: (unsigned long)timeStampSecond;
+(NSDate*)dateFromTimeStampMillisecond: (unsigned long)timeStampMillisecond;
+(NSDate*)dateFromTimeStampMicrosecond: (unsigned long)timeStampMicrosecond;

// 字符<->NSDate 格式转换
+(NSDate*)dateFromString:(NSString*)datestring withFormat: (NSString*)dateformat;
+(NSString*)stringFromDate:(NSDate*)date withFormat: (NSString*)dateformat;


// 时间间隔
+(JZIntervalDateComponents*)IntervalHumanTimeSinceDate:(NSDate*)date1 ToDate:(NSDate*)date2;



@end






@interface JZIntervalDateComponents : NSObject

@property NSInteger year;
@property NSInteger month;
@property NSInteger day;
@property NSInteger hour;
@property NSInteger minute;
@property NSInteger second;

@end



