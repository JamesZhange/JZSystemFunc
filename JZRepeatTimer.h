//
//  JZRepeatTimer.h
//  JZSystemFuncDemon
//
//  Created by Liu Rui on 15/2/3.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZRepeatTimer : NSObject

+(JZRepeatTimer*)newInstance;

-(void)startTimerTimingSecond: (NSTimeInterval)second
                        block: (void (^)())timerBlock
                       repeat: (BOOL)yesOrNo;

-(void)pauseTimer;
-(void)resumeTimer;
-(void)stopTimer;

@end
