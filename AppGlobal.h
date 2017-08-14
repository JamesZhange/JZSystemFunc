//
//  FADGlobal.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/2/5.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 不需要 FADGlobal.h 的头文件
#import "SingletonObjDefine.h"
#import "JZMultiDelegateObject.h"
#import "JZMultiDelegateUIView.h"
#import "JZLockTimer.h"
#import "JZTimer.h"
#import "JZMath.h"
#import "JZColorHelper.h"
#import "JZDateHelper.h"
#import "JZLocation.h"
#import "JZMemory.h"
#import "JZStringHelper.h"
//#import "ALSystem.h"
#import "JZView.h"
#import "JZCompatibleAlert.h"
#import "JZImageHelper.h"
#import "JZURLRequest.h"
#import "LongpressReorderTableView.h"
#import "UIScrollView+subviews.h"
#import "JZGestureScrollView.h"
#import "JZCopyableLabel.h"
#import "JZActivityIndicatorMgr.h"
#import "NSString+containsSubString.h"
#import "NSString+chineseNumberals.h"
#import "NSString+IgnoreCaseCompare.h"
#import "NSURLConnection+tag.h"
#import "NetworkReachability.h"





#pragma mark - global define

#define IOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)


#define DISPATCHTIME(t) (dispatch_time(DISPATCH_TIME_NOW, (int64_t)((t) * NSEC_PER_SEC)))




// 多语言替换宏
// #define FALocalizedString(key, comment) NSLocalizedString(key, comment)
#define JZLocalStr(key, comment) [AppGlobal DPLocalizedString:key]


// #define DLOG  NSLog
#define DLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
// #define DLOG



// G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


// #define FACPrintf
#define FACPrintf	printf


// release 版宏
// #define CODE_FOR_RELEASE  1


// OpenEars 库 宏
// #define USE_OPENEARS_LIB    1  // 因为和讯飞的库冲突，无法一起编译


/*********************************************************/
/***************     interface FADGlobal   ***************/
/*********************************************************/

#pragma mark - FADGlobal class

#define FAIRAIRBLEPASSWORDLENGTH        6
#define FAIRAIRWiFiPASSWORDLENGTH       64
#define FAIRAIRDEVICENAMELENGTH         20

@interface AppGlobal : NSObject


// 多语言默认语言选择
+ (NSString *)DPLocalizedString:(NSString *)translation_key;


+(NSString*)getWeekStrWithDate: (NSDate*)date;


// 当前 UIViewController
+(UIViewController *)currentViewController;



+(NSString*)AppDocumentsPatch;
+(NSString*)AppDocumentsFilePatch: (NSString*)filename;

+(NSString*)AppCacheDirectoryPatch;
+(NSString*)AppCacheDirectoryFilePatch: (NSString*)filename;



@end














