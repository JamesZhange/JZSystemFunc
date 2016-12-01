//
//  JZUrlCreater.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 2016/12/1.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZURLRequest.h"







@interface JZURLRequest()
{
    NSURL* mUrl;
    NSString* mMethod;
    NSMutableDictionary* mBodyDic;
}

@property (nonatomic, strong) NSURL* URL;
@property (nonatomic, strong) NSString* Method;

@end






@implementation JZURLRequest

-(instancetype)init{
    self = [super init];
    if (nil != self) {
        mUrl = nil;
        mBodyDic = nil;
        mMethod = HTTPMETHOD_GET;
    }
    return self;
}

+(JZURLRequest*)requestWithURL: (NSURL*)url
                   httpMethod: (NSString*)method
{
    if ((nil != url)
        && (nil != method))
    {
        JZURLRequest* request = [[JZURLRequest alloc] init];
        
        request.URL = url;
        request.Method = method;
        
        return request;
    }
    return nil;
}


-(void)addValue:(NSString*)value forBodyParameter:(NSString*)key
{
    if ((nil != value) && (nil != key)) {
        if (nil == mBodyDic) {
            mBodyDic = [[NSMutableDictionary alloc] init];
        }
        
        [mBodyDic setObject: value forKey: key];
    }
}

-(void)removeBodyParameter:(NSString*)key
{
    if ((nil != mBodyDic) && (nil != key)) {
        [mBodyDic removeObjectForKey: key];
    }
}



#pragma mark - property

-(NSURL*) URL {
    return mUrl;
}
-(void)setURL:(NSURL *)URL {
    mUrl = URL;
}

-(NSString*) Method {
    return mMethod;
}
-(void)setMethod:(NSString *)Method {
    mMethod = Method;
}


-(NSURLRequest*)request {
    return [self packagingRequest];
}

-(NSURLRequest*)packagingRequest
{
    if (nil == mUrl) {
        return nil;
    }
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL: mUrl];
    [request setHTTPMethod: mMethod];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval: 15];
    
    if ((nil != mBodyDic) && (0 != [mBodyDic allKeys].count)) {
        NSString* bodystr = @"";
        for (NSString* key in [mBodyDic allKeys]) {
            NSString* value = [mBodyDic objectForKey: key];
            bodystr = [bodystr stringByAppendingString: [NSString stringWithFormat: @"%@=%@&", key, value]];
        }
        
        bodystr = [bodystr substringToIndex: (bodystr.length-1)];
        
        [request setHTTPBody:[bodystr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return request;
}

@end




