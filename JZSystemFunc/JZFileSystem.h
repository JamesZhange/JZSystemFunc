//
//  JZFileSystem.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 2017/9/27.
//  Copyright © 2017年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZFileSystem : NSObject


+(NSString*)AppDocumentsPatch;
+(NSString*)AppDocumentsFilePatch: (NSString*)filename;

+(NSString*)AppCacheDirectoryPatch;
+(NSString*)AppCacheDirectoryFilePatch: (NSString*)filename;



@end
