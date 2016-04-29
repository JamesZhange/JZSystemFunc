//
//  JZView.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/4/15.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZView : UIView

// 渐变背景
@property(nonatomic, strong) NSArray *gradientColors;
@property(nonatomic, strong) NSArray<NSNumber *> *gradientLocations;
@property CGPoint gradientStartPoint;
@property CGPoint gradientEndPoint;



@end
