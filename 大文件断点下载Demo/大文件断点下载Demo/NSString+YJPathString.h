//
//  NSString+YJPathString.h
//  归档(Demo)
//
//  Created by  jason on 15/11/23.
//  Copyright © 2015年 renlairenwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YJPathString)

/**
 *  获取主路径
 *
 *  @return 主要路径
 */
+(NSString*)stringOfHomePath;

/**
 *  获取document路径
 *
 *  @return document路径
 */
+(NSString*)stringOfDocumentPath;

/**
 *  获取caches路径
 *
 *  @return caches路径
 */
+(NSString*)stringOfCaches;

/**
 *  获取tmp路径
 *
 *  @return tmp路径
 */
+(NSString*)stringOfTmp;

@end
