//
//  JZDateHelper.h
//  AirDefender
//
//  Created by Liu Rui on 2017/5/18.
//  Copyright © 2017年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface JZDateHelper : NSObject

// 时间戳
+(unsigned long)NowTimeStampSecond;
+(unsigned long)NowTimeStampMillisecond;
+(unsigned long)NowTimeStampMicrosecond;

+(unsigned long)timeStampSecondFromDate: (NSDate*)date;
+(unsigned long)timeStampMillisecondFromDate: (NSDate*)date;
+(unsigned long)timeStampMicrosecondFromDate: (NSDate*)date;

+(NSDate*)dateFromTimeStampSecond: (unsigned long)timeStampSecond;
+(NSDate*)dateFromTimeStampMillisecond: (unsigned long)timeStampMillisecond;
+(NSDate*)dateFromTimeStampMicrosecond: (unsigned long)timeStampMicrosecond;

// 格式转换
+(NSDate*)dateFromString:(NSString*)datestring withFormat: (NSString*)dateformat;
+(NSString*)stringFromDate:(NSDate*)date withFormat: (NSString*)dateformat;

@end
