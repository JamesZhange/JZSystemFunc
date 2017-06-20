//
//  FADGlobal.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/2/5.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import "AppGlobal.h"

@implementation AppGlobal


#pragma mark - 默认语言选择
#define CURR_LANG  ([[NSLocale preferredLanguages] objectAtIndex:0])

+ (NSString *)DPLocalizedString:(NSString *)translation_key {
    
    NSString * s = NSLocalizedString(translation_key, nil);
    
    if (![CURR_LANG hasPrefix:@"en"] && ![CURR_LANG hasPrefix:@"zh-Hans"]) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
        
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        
        s = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
        
    }
    
    return s;
    
}



#pragma mark - 当前 UIViewController

+(UIViewController *)currentViewController{
    
    UIViewController *viewC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    return viewC;
}



#pragma mark - Other

+(NSString*)getWeekStrWithDate: (NSDate*)date
{
    // 用 NSDateFormatter 的 EEE 可以格式化出 week
    
    NSString *retString = nil;
    
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [componets weekday];
    
    switch (weekday) {
        case 1:
            retString = JZLocalStr(@"周日", nil);
            break;
        case 2:
            retString = JZLocalStr(@"周一", nil);
            break;
        case 3:
            retString = JZLocalStr(@"周二", nil);
            break;
        case 4:
            retString = JZLocalStr(@"周三", nil);
            break;
        case 5:
            retString = JZLocalStr(@"周四", nil);
            break;
        case 6:
            retString = JZLocalStr(@"周五", nil);
            break;
        case 7:
            retString = JZLocalStr(@"周六", nil);
            break;
        default:
            break;
    }
    
    return retString;
}


//获取应用程序沙盒的Documents目录
+(NSString*)AppDocumentsPatch
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *Path = [paths objectAtIndex:0];
    
    return Path;
}

+(NSString*)AppDocumentsFilePatch: (NSString*)filename
{
    return [[AppGlobal AppDocumentsPatch] stringByAppendingPathComponent: filename];
}


+(NSString*)AppCacheDirectoryPatch
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *Path = [paths objectAtIndex:0];
    return Path;
}
+(NSString*)AppCacheDirectoryFilePatch: (NSString*)filename
{
    return [[AppGlobal AppCacheDirectoryPatch] stringByAppendingPathComponent: filename];
}

@end







