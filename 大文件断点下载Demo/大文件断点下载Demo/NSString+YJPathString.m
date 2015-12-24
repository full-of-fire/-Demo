//
//  NSString+YJPathString.m
//  归档(Demo)
//
//  Created by  jason on 15/11/23.
//  Copyright © 2015年 renlairenwang. All rights reserved.
//

#import "NSString+YJPathString.h"

@implementation NSString (YJPathString)

/**
 *  获取主路径
 *
 *  @return 主要路径
 */
+(NSString*)stringOfHomePath {

    return NSHomeDirectory();
}

/**
 *  获取document路径
 *
 *  @return document路径
 */
+(NSString*)stringOfDocumentPath {

    return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  获取caches路径
 *
 *  @return caches路径
 */
+(NSString*)stringOfCaches {

  return   [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  获取tmp路径
 *
 *  @return tmp路径
 */
+(NSString*)stringOfTmp {

    return NSTemporaryDirectory();
}

@end
