//
//  JZDateHelper.m
//  AirDefender
//
//  Created by Liu Rui on 2017/5/18.
//  Copyright © 2017年 Liu Rui. All rights reserved.
//

#import "JZDateHelper.h"




@implementation JZDateHelper



+(unsigned long)NowTimeStampSecond
{
    NSDate *date = [NSDate date];
    unsigned long timestamp = (unsigned long)([date timeIntervalSince1970]);
    return timestamp;
}

+(unsigned long)NowTimeStampMillisecond
{
    NSDate *date = [NSDate date];
    unsigned long timestamp = (unsigned long)([date timeIntervalSince1970] * 1000);
    return timestamp;
}

+(unsigned long)NowTimeStampMicrosecond
{
    NSDate *date = [NSDate date];
    unsigned long timestamp = (unsigned long)([date timeIntervalSince1970] * 1000 * 1000);
    return timestamp;
}

+(unsigned long)timeStampSecondFromDate: (NSDate*)date
{
    unsigned long timestamp = (unsigned long)([date timeIntervalSince1970]);
    return timestamp;
}

+(unsigned long)timeStampMillisecondFromDate: (NSDate*)date
{
    unsigned long timestamp = (unsigned long)([date timeIntervalSince1970] * 1000);
    return timestamp;
}

+(unsigned long)timeStampMicrosecondFromDate: (NSDate*)date
{
    unsigned long timestamp = (unsigned long)([date timeIntervalSince1970] * 1000 * 1000);
    return timestamp;
}


+(NSDate*)dateFromTimeStampSecond: (unsigned long)timeStampSecond
{
    NSTimeInterval second = ((NSTimeInterval)timeStampSecond);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: second];
    return date;
}

+(NSDate*)dateFromTimeStampMillisecond: (unsigned long)timeStampMillisecond
{
    NSTimeInterval second = ((NSTimeInterval)timeStampMillisecond) / (1000.0);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: second];
    return date;
}

+(NSDate*)dateFromTimeStampMicrosecond: (unsigned long)timeStampMicrosecond
{
    NSTimeInterval second = ((NSTimeInterval)timeStampMicrosecond) / (1000 * 1000.0);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: second];
    return date;
}


// 格式转换
+(NSDate*)dateFromString:(NSString*)datestring withFormat: (NSString*)dateformat
{
    if ((nil == datestring) || (nil == dateformat) || (0 == [datestring length]) || (0 == [dateformat length])) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateFormat : dateformat];
    NSDate * date = [formatter dateFromString: datestring];
    return date;
}

+(NSString*)stringFromDate:(NSDate*)date withFormat: (NSString*)dateformat // @"yyyy-MM-dd hh:mm:ss"
{
    if ((nil == date) || (nil == dateformat) || (0 == [dateformat length])) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateFormat: dateformat ];
    return [formatter stringFromDate: date];
}





@end


