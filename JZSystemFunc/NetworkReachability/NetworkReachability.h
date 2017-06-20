//
//  NetworkReachability.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/2/29.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZMultiDelegateObject.h"
#import "AppGlobal.h"


typedef NS_ENUM(int, eumNetworkReachState) {
    eumNetReach_NotReachable = -1,
    eumNetReach_Initing,
    eumNetReach_ReachableWiFi,
    eumNetReach_ReachableWWAN,
};

typedef NS_ENUM(int, eumFAServerReachState) {
    eumFAServerReach_NotReachable = -1,
    eumFAServerReach_Initing,
    eumFAServerReach_Reachable,
};


@interface NetworkReachability : JZMultiDelegateObject
SYNTHESIZE_SINGLETON_FOR_HEADER(NetworkReachability);

@property (nonatomic, readonly) eumNetworkReachState NetworkReachable;
@property (nonatomic, readonly) eumFAServerReachState FAServerReachable;

-(void) startMonitorNetwork;
-(void) stopMonitorNetwork;

@end


@protocol NetworkReachabilityDelegate <NSObject>

@optional
-(void)reachableStateChangedNetWork: (eumNetworkReachState)networkReachable
                           FAServer: (eumFAServerReachState)faserverReachable;

@end
