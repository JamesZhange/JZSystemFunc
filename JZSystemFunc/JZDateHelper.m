//
//  JZDateHelper.m
//  AirDefender
//
//  Created by Liu Rui on 2017/5/18.
//  Copyright © 2017年 Liu Rui. All rights reserved.
//

#import "JZDateHelper.h"



@implementation JZDateHelper


#pragma mark - 时间戳

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


#pragma mark - 格式转换
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



#pragma mark - 间隔

// NSCalendarUnitYear NSCalendarUnitMonth  NSCalendarUnitDay NSCalendarUnitWeekday NSCalendarUnitHour NSCalendarUnitMinute NSCalendarUnitSecond

+(JZIntervalDateComponents*)IntervalHumanTimeSinceDate:(NSDate*)date1 ToDate:(NSDate*)date2
{
    if ((nil == date1) || (nil == date2)) {
        return nil;
    }
    NSDate* earlyDate = nil;
    NSDate* lateDate = nil;
    if (NSOrderedAscending == [date1 compare: date2]) {
        earlyDate = date1;
        lateDate = date2;
    } else {
        earlyDate = date2;
        lateDate = date1;
    }

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:  NSCalendarIdentifierGregorian];//设置成中国阳历(公历)
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond; // 需要的格式，用 “|” 组装，没有填写的格式不会在 NSDateComponents 中出现

    NSDateComponents* earlyDateComps = [calendar components:unitFlags fromDate: earlyDate];
    NSDateComponents* lateDateComps = [calendar components:unitFlags fromDate: lateDate];
    
    // NSLog(@"earlyDate: %@ \nvs\n laterDate: %@", earlyDateComps, lateDateComps);
    
    //
    JZIntervalDateComponents* intervalcomp = [[JZIntervalDateComponents alloc] init];
    
    intervalcomp.year = lateDateComps.year - earlyDateComps.year;
    intervalcomp.month = lateDateComps.month - earlyDateComps.month;
    intervalcomp.day = lateDateComps.day - earlyDateComps.day;
    intervalcomp.hour = lateDateComps.hour - earlyDateComps.hour;
    intervalcomp.minute = lateDateComps.minute - earlyDateComps.minute;
    intervalcomp.second = lateDateComps.second - earlyDateComps.second;
    BOOL needReduceOndDay = NO;
    
    if (intervalcomp.second < 0)
    {
        intervalcomp.minute -= 1;
        intervalcomp.second += 60;
    }
    if (intervalcomp.minute < 0)
    {
        intervalcomp.hour -= 1;
        intervalcomp.minute += 60;
    }
    if (intervalcomp.hour < 0)
    {
        needReduceOndDay = YES;
        intervalcomp.day -= 1;
        intervalcomp.hour += 24;
    }
    if (intervalcomp.day < 0)
    {
        if ((intervalcomp.month < 1) && (intervalcomp.year < 1)) {
            NSLog(@"date compare some thing wrong!");
            return nil;
        }
        
        NSInteger dayInterval = [self dayApartFromDate:lateDate ToLastMonthThisDay: earlyDateComps.day];
        if (0 != dayInterval) {
            intervalcomp.day = dayInterval;
            if (YES == needReduceOndDay) {
                intervalcomp.day -= 1;
            }
            intervalcomp.month -= 1;
        } else {
            return nil;
        }
    }
    if (intervalcomp.month < 0) {
        if (intervalcomp.year < 1) {
            NSLog(@"date compare some thing wrong!");
            return nil;
        }
        
        intervalcomp.year -= 1;
        intervalcomp.month += 12;
    }
    
    return intervalcomp;
}


+(NSInteger)dayApartFromDate:(NSDate*)endDate ToLastMonthThisDay:(NSInteger)calendarDay
{
    if ((nil == endDate) || (calendarDay<0) || (calendarDay>31)) {
        return 0;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:  NSCalendarIdentifierGregorian];//设置成中国阳历(公历)
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay; // 需要的格式，用 “|” 组装，没有填写的格式不会在 NSDateComponents 中出现
    NSDateComponents* endDateComps = [calendar components:unitFlags fromDate: endDate];
    
    NSInteger year = endDateComps.year;
    NSInteger month = endDateComps.month;
    NSInteger day = endDateComps.day;
    
    if (31 == calendarDay) {
        return day;
    }
    
    month -= 1;
    if (0 == month) {
        month = 12;
        year -= 1;
    }
    
    NSDateComponents* lastMonthDayComps = [[NSDateComponents alloc] init];
    [lastMonthDayComps setYear: year];
    [lastMonthDayComps setMonth: month];
    [lastMonthDayComps setDay: calendarDay];
    NSDate *startDate = [calendar dateFromComponents: lastMonthDayComps];
    
    NSTimeInterval intervalsecond = [endDate timeIntervalSinceDate: startDate];
    
    NSInteger intervalDay = ((NSInteger)intervalsecond) / (60*60*24);
    
    return intervalDay;
}

@end





/******************************************************************/
/*******            JZIntervalDateComponents               ********/
/******************************************************************/
#pragma mark - @implementation JZIntervalDateComponents

@implementation JZIntervalDateComponents
-(instancetype)init{
    self = [super init];
    if (nil != self) {
        _year = 0;
        _month = 0;
        _day = 0;
        _hour = 0;
        _minute = 0;
        _second = 0;
    }
    return self;
}
@end

