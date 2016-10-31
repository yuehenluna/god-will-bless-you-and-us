//
//  NSObject+Extend.h
//  kActivity
//
//  Created by zhaoke on 16/10/25.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extend)

/**
 *   --z KVO
 */
- (void)addObserverBlockForKeyPath:(NSString *)keyPath block:(void(^)(id obj, id oldValue, id newValue))block;
- (void)removeObserBlocksForKeyPath:(NSString *)keyPath;
- (void)removeObserverBlocks;

@end
