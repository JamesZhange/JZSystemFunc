//
//  JZTimer.h
//  JZSystemFuncDemon
//
//  Created by Liu Rui on 15/2/3.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTimer : NSObject

@property (nonatomic, readonly) BOOL isRunning;

+(JZTimer*)newTimer;

-(void)startTimerTimingSecond: (NSTimeInterval)second
                        block: (void (^)())timerBlock
                       repeat: (BOOL)yesOrNo;

-(void)pauseTimer;
-(void)resumeTimer;
-(void)stopTimer;

-(void)fire;

// 封装一些常用操作
+(void)delayTimingSecond: (NSTimeInterval)second
                RunBlock: (void (^)())timerBlock;

@end
