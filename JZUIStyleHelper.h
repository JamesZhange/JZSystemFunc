//
//  JZUIStyleHelper.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/3/12.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZUIStyleHelper : NSObject

+ (UIColor *)colorFromHexRGB:(const NSString *)inColorString;
+ (UIColor *)colorFromHexRGBA:(const NSString *)inColorString;


@end


#define ColorRGB(rgbstring)  [JZUIStyleHelper colorFromHexRGB: rgbstring]
#define ColorRGBA(rgbstring)  [JZUIStyleHelper colorFromHexRGBA: rgbstring]
#define ColorR_G_B(fred,fgreen,fblue) [UIColor colorWithRed:(fred) green:(fgreen) blue:(fblue) alpha:1]
#define ColorR_G_B_A(fred,fgreen,fblue,falpha) [UIColor colorWithRed:(fred) green:(fgreen) blue:(fblue) alpha:(falpha)]
