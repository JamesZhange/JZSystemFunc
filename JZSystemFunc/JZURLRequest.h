//
//  JZUrlCreater.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 2016/12/1.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>


#define HTTPMETHOD_GET          @"GET"
#define HTTPMETHOD_POST         @"POST"



@interface JZURLRequest : NSObject

@property(nonatomic, readonly) NSURLRequest *request;

+(JZURLRequest*)requestWithURL: (NSURL*)url
                    httpMethod: (NSString*)method;

-(void)addValue:(NSString*)value
forBodyParameter:(NSString*)key;

-(void)removeBodyParameter:(NSString*)key;


@end
