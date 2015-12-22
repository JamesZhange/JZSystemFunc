//
//  JZRepeatTimer.m
//  JZSystemFuncDemon
//
//  Created by Liu Rui on 15/2/3.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import "JZRepeatTimer.h"

@interface JZRepeatTimer()
{
    BOOL mRepeat;
    NSTimeInterval mSecond;
    NSTimer* timer;
    void (^mCompletion)(void);
}

@end



@implementation JZRepeatTimer

-(id)init
{
    self = [super init];
    if (self) {
        timer = nil;
        mCompletion = nil;
    }
    return self;
}

-(void)dealloc
{
    [self stopTimer];
}


+(JZRepeatTimer*)newInstance
{
    return [[JZRepeatTimer alloc] init];
}


-(void)startTimerTimingSecond: (NSTimeInterval)second
                        block: (void (^)())timerBlock
                       repeat: (BOOL)yesOrNo
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    mCompletion = timerBlock;
    mSecond = second;
    mRepeat = yesOrNo;
    
    timer = [NSTimer scheduledTimerWithTimeInterval: second
                                             target: self
                                           selector: @selector(onTheTime)
                                           userInfo: nil repeats:yesOrNo];  
}


-(void)onTheTime
{
    if (nil != mCompletion) {
        mCompletion();
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
}



-(void)stopTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

@end
