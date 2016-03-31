//
//  JZImageHelper.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/3/31.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JZImageHelper : NSObject

+(UIImage *)scaleFromImage: (UIImage*)image
                    toSize: (CGSize)size;

@end
