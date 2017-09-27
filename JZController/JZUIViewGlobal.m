//
//  JZUIViewGlobal.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 2017/9/27.
//  Copyright © 2017年 Liu Rui. All rights reserved.
//

#import "JZUIViewGlobal.h"




@implementation JZUIViewGlobal


#pragma mark - 当前 UIViewController

+(UIViewController *)currentViewController{
    
    UIViewController *viewC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    return viewC;
}

@end
