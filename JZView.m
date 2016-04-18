//
//  JZView.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/4/15.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZView.h"

@interface JZView()
{
    CAGradientLayer* gradientLayer;
    NSArray* mGradientColorArray;
}

@end





@implementation JZView




-(void)initParameters
{
    mGradientColorArray = nil;
    _gradientLocations = nil;
    _gradientStartPoint = CGPointMake(0, 0.5);
    _gradientEndPoint = CGPointMake(1.0, 0.5);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (nil != mGradientColorArray) {
        
        [self drawGradientColor];
        
    }
}



#pragma mark - property

-(NSArray*)gradientColors
{
    return mGradientColorArray;
}
-(void)setGradientColors:(NSArray *)gradientColors
{
    if ((nil != gradientColors) && (gradientColors.count > 0)) {
        if ([gradientColors[0] isKindOfClass: [UIColor class]]) {  // 补丁，外边有时候会写错成UIColor
            NSMutableArray* cgcolorarray = [NSMutableArray array];
            for (UIColor* color in gradientColors) {
                [cgcolorarray addObject: (id)(color.CGColor)];
            }
            mGradientColorArray = cgcolorarray;
        } else {
            mGradientColorArray = gradientColors;
        }
        
        [self setBackgroundColor: [UIColor clearColor]];
        
    } else {
        mGradientColorArray = nil;
    }
}



#pragma mark - 渐变色背景
-(void)drawGradientColor
{
    if (nil == mGradientColorArray) {
        return;
    }
    if (nil != gradientLayer) {
        [gradientLayer removeFromSuperlayer];
    }
    gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = self.bounds;
    gradientLayer.frame = self.bounds;
    gradientLayer.borderWidth = 0;
    
    gradientLayer.colors = mGradientColorArray;
    
    if (nil != _gradientLocations) {
        gradientLayer.locations = _gradientLocations;
    }
    gradientLayer.startPoint = _gradientStartPoint;
    gradientLayer.endPoint = _gradientEndPoint;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    NSLog(@"gradlayer frame: x: %d, y: %d, w: %d, h: %d", (int)gradientLayer.frame.origin.x, (int)gradientLayer.frame.origin.y, (int)gradientLayer.frame.size.width, (int)gradientLayer.frame.size.height);
}





@end
