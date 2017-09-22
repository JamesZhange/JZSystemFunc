//
//  JZTimer.m
//  JZSystemFuncDemon
//
//  Created by Liu Rui on 15/2/3.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import "JZTimer.h"

@interface JZTimer()
{
    BOOL mRepeat;
    unsigned int nRepeatTimes;
    NSTimeInterval mSecond;
    NSTimer* timer;
    void (^mCompletion)(void);
}

@end



@implementation JZTimer

-(id)init
{
    self = [super init];
    if (self) {
        timer = nil;
        mCompletion = nil;
        _isRunning = NO;
        nRepeatTimes = 0;
    }
    return self;
}

-(void)dealloc
{
    [self stopTimer];
}


+(JZTimer*)newTimer
{
    return [[JZTimer alloc] init];
}

+(void)delayTimingSecond: (NSTimeInterval)second
                RunBlock: (void (^)())timerBlock
{
    [[JZTimer newTimer] startTimerTimingSecond:second block:timerBlock repeat:NO];
}


-(void)startTimerTimingSecond: (NSTimeInterval)second
                        block: (void (^)())timerBlock
                       repeat: (BOOL)yesOrNo
{
    if (timer) {
        [timer invalidate];
        timer = nil;
        _isRunning = NO;
    }
    mCompletion = timerBlock;
    mSecond = second;
    mRepeat = yesOrNo;
    
    timer = [NSTimer scheduledTimerWithTimeInterval: second
                                             target: self
                                           selector: @selector(onTheTime)
                                           userInfo: nil repeats:yesOrNo];
    _isRunning = YES;
}

-(void)startTimerTimingSecond: (NSTimeInterval)second
                        block: (void (^)())timerBlock
                  repeatTimes: (unsigned int)repeattimes
{
    if (0 != repeattimes) {
        nRepeatTimes = repeattimes + 1; // nRepeatTimes 定义为无符号值，“+1“操作为判断停止提供条件
        [self startTimerTimingSecond: second
                               block: timerBlock
                              repeat: YES];
        
    } else {
        [self startTimerTimingSecond: second
                               block: timerBlock
                              repeat: NO];
    }
}


-(void)onTheTime
{
    if (nil != mCompletion) {
        mCompletion();
    }
    nRepeatTimes--;
    if (0 == nRepeatTimes) {
        [self stopTimer];
    }
}

-(void)fire
{
    if (timer) {
        [timer fire];
    }
}

-(void)pauseTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

-(void)resumeTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }

    timer = [NSTimer scheduledTimerWithTimeInterval: mSecond
                                             target: self
                                           selector: @selector(onTheTime)
                                           userInfo: nil repeats:mRepeat];
    _isRunning = YES;
}



-(void)stopTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    _isRunning = NO;
}

@end
