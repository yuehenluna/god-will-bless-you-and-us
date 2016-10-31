//
//  NetWorkingCache.h
//  AFNetworking3.x封装
//
//  Created by zhaoke on 16/8/31.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"

@interface NetWorkingCache : NSObject

/**
 * -- 缓存网络数据
 */
+ (void)saveNetworkingCache:(id)cache forKey:(NSString *)key;
/**
 * -- 读取缓存数据
 */
+ (id)getNetworkingCacheForKey:(NSString *)key;
/**
 * -- 获取网络缓存的大小
 */
+ (NSInteger)getNetworkingCacheSize;
/**
 * -- 删除所有缓存
 */
+ (void)clearAllNetworkingCache;

@end
