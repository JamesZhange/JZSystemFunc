//
//  JZFileSystem.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 2017/9/27.
//  Copyright © 2017年 Liu Rui. All rights reserved.
//

#import "JZFileSystem.h"




@implementation JZFileSystem


//获取应用程序沙盒的Documents目录
+(NSString*)AppDocumentsPatch
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *Path = [paths objectAtIndex:0];
    
    return Path;
}

+(NSString*)AppDocumentsFilePatch: (NSString*)filename
{
    return [[JZFileSystem AppDocumentsPatch] stringByAppendingPathComponent: filename];
}


+(NSString*)AppCacheDirectoryPatch
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *Path = [paths objectAtIndex:0];
    return Path;
}
+(NSString*)AppCacheDirectoryFilePatch: (NSString*)filename
{
    return [[JZFileSystem AppCacheDirectoryPatch] stringByAppendingPathComponent: filename];
}


@end
