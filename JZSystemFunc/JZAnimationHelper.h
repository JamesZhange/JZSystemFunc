//
//  JZAnimationHelper.h
//  DearBabyObjC
//
//  Created by Liu Rui on 2017/8/14.
//  Copyright © 2017年 James. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JZAnimationHelper : NSObject

// UIView animateWithDuration 动画中，旋转动画(self.SunImage.transform = CGAffineTransformMakeRotation(angle);)
// 设置旋转锚点用接口
// Used: [JZAnimationHelper setAnchorPoint:CGPointMake(0.5, 1) forView: self.someView];
+(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;

@end
