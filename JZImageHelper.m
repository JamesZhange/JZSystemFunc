//
//  JZImageHelper.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/3/31.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZImageHelper.h"

@implementation JZImageHelper

// 改变图像的尺寸
+(UIImage *)scaleFromImage: (UIImage*)image
                    toSize: (CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
