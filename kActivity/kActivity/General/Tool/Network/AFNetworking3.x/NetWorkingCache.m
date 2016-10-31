//
//  NetWorkingCache.m
//  AFNetworking3.x封装
//
//  Created by zhaoke on 16/8/31.
//  Copyright © 2016年 zk. All rights reserved.
//

#import "NetWorkingCache.h"

static NSString *const NetworkCache = @"NetworkCache";
static YYCache *_kdataCache;

@implementation NetWorkingCache

+ (void)initialize {
    _kdataCache = [[YYCache alloc] initWithName:NetworkCache];
}
+ (void)saveNetworkingCache:(id)cache forKey:(NSString *)key {
    // 异步执行
    [_kdataCache setObject:cache forKey:key withBlock:nil];
}
+ (id)getNetworkingCacheForKey:(NSString *)key {
    return [_kdataCache objectForKey:key];
}
+ (NSInteger)getNetworkingCacheSize {
    return [_kdataCache.diskCache totalCost];
}
+ (void)clearAllNetworkingCache {
    [_kdataCache.diskCache removeAllObjects];
}

@end
