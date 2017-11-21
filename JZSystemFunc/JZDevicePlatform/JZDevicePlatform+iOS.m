//
//  JZDevicePlatform+iOS.m
//  AirDefender
//
//  Created by Liu Rui on 2017/9/27.
//  Copyright © 2017年 Liu Rui. All rights reserved.
//

#import "JZDevicePlatform.h"
#import "UIDeviceHardware.h"
#import "JZGlobal.h"


@implementation JZDevicePlatform (iOS)


#pragma mark - 硬件相关
// helper
+(BOOL)isDevice_iPhoneX
{
    NSString* platform = [UIDeviceHardware platformStringSimple];
    
#if 1
    if ([platform isEqualIgnoreCaseToString: @"iPhone X"])
    {
        return YES;
    } else {
        return NO;
    }
#else // simulator debug // 模拟器调试
    if (([platform isEqualIgnoreCaseToString: @"iPhone X"])
        || ([platform isEqualIgnoreCaseToString: @"Simulator"]))
    {
        return YES;
    } else {
        return NO;
    }
#endif
}



@end
