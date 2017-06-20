//
//  NetworkReachability.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/2/29.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "NetworkReachability.h"
#import "AppGlobal.h"
#import "TonyReachability.h"
#import "NSURLConnection+tag.h"

typedef enum {
    CONNECTTAG_TESTFASERVER = 1,
}eumConnectTag;


#define TESTNETUSEHOSTNAME              @"www.baidu.com"
#define TESTFASERVERDOMAIN              @"https://api.fairair.me/airdefender/time"

#define QUERYFASERVERSIRCULINTERVAL     10

@interface NetworkReachability ()
{
    JZTimer* SirculQueryFAServerTimer;
    NSMutableData* receiveData;
    
    eumNetworkReachState lastNetworkReachable;
    eumFAServerReachState lastFAServerReachable;
}
@property (strong, nonatomic) TonyReachability* hostReach;

@end




@implementation NetworkReachability
SYNTHESIZE_SINGLETON_FOR_CLASS(NetworkReachability);

-(id)init
{
    self = [super init];
    if (nil != self) {
        
        _NetworkReachable = eumNetReach_Initing;
        _FAServerReachable = eumFAServerReach_Initing;
        lastNetworkReachable = _NetworkReachable;
        lastFAServerReachable = _FAServerReachable;
        SirculQueryFAServerTimer = [[JZTimer alloc] init];
        
        __weak typeof(self) weakSelf = self;
        
        self.hostReach = [TonyReachability reachabilityWithHostName: TESTNETUSEHOSTNAME] ;
        self.hostReach.reachableBlock = ^(TonyReachability * reachability)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                typeof(weakSelf) __strong strongSelf = weakSelf;
                
                // "网络可用";
                // DLOG(@"网络可用");
                if (reachability.isReachableViaWiFi) {
                    DLOG(@"当前通过wifi连接");
                    _NetworkReachable = eumNetReach_ReachableWiFi;
                    [strongSelf startMonitorFAServer];
                    [strongSelf sendStateToDelegate];
                    
                } else {
                    // DLOG(@"wifi未开启，不能用");
                    // [strongSelf sendStateToDelegate];
                }
                
                if (reachability.isReachableViaWWAN) {
                    DLOG(@"当前通过 3G or 4G 连接");
                    _NetworkReachable = eumNetReach_ReachableWWAN;
                    [strongSelf startMonitorFAServer];
                    [strongSelf sendStateToDelegate];
                } else {
                    // DLOG(@"3g or 4g网络未使用");
                    // [strongSelf sendStateToDelegate];
                }
            });
        };
        
        self.hostReach.unreachableBlock = ^(TonyReachability * reachability)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                typeof(weakSelf) __strong strongSelf = weakSelf;
                DLOG(@"网络不可用");
                
                _NetworkReachable = eumNetReach_NotReachable;
                [strongSelf sendStateToDelegate];
                [strongSelf stopMonitorFAServer];
            });
        };
    }
    return self;
}

// 根据优先级发送不同数据到接收者
-(void)sendStateToDelegate {
    
    if ((lastNetworkReachable != _NetworkReachable)
        || (lastFAServerReachable != _FAServerReachable))
    {
        [multiDelegate reachableStateChangedNetWork: _NetworkReachable
                                           FAServer: _FAServerReachable];
        lastNetworkReachable = _NetworkReachable;
        lastFAServerReachable = _FAServerReachable;
    }
}


#pragma mark - 网络访问
-(void) startMonitorNetwork
{
    [self.hostReach startNotifier];
}

-(void) stopMonitorNetwork
{
    [self stopMonitorFAServer];
    [self.hostReach stopNotifier];
}


#pragma mark - 朗空服务器访问
-(void)startMonitorFAServer
{
    [SirculQueryFAServerTimer startTimerTimingSecond: QUERYFASERVERSIRCULINTERVAL
                                               block: ^(){
                                                   [self testConnectFAServer];
                                               } repeat: YES];
    [SirculQueryFAServerTimer fire];
}

-(void)stopMonitorFAServer
{
    [SirculQueryFAServerTimer stopTimer];
}

-(void)testConnectFAServer {
    
    JZURLRequest* request = [JZURLRequest requestWithURL: TESTFASERVERDOMAIN httpMethod: HTTPMETHOD_GET];
    // 访问
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest: request.request delegate:self];
    connection.tag = [NSNumber numberWithInt: CONNECTTAG_TESTFASERVER];
    [connection start];
}




#pragma mark - Http connected delegate


//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receiveData = [NSMutableData data];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}

//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    int connectionTag = (int)[connection.tag integerValue];
    
    NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    // NSLog(@"%@",receiveStr);
    
    if (nil == receiveStr) {
        return;
    }
    
    // NSString *requestTmp = [NSString stringWithString:receiveStr];
    // NSData *resData = [[NSData alloc] initWithData:[receiveStr dataUsingEncoding:NSUTF8StringEncoding]];
    //系统自带JSON解析
    // NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    
    switch (connectionTag) {
            
        case CONNECTTAG_TESTFASERVER:
        {
            // 收到的是：{"currentTimeMillis":"1488531806349"}
            _FAServerReachable = eumFAServerReach_Reachable;
            [self sendStateToDelegate];
            NSLog(@"正常连接朗空服务器");
        }
            break;
        default:
            break;
    }
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"Test Fairair server http connection error: %@",[error localizedDescription]);
    
    _FAServerReachable = eumFAServerReach_NotReachable;
    [self sendStateToDelegate];
}





@end
