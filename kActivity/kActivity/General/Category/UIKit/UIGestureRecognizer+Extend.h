//
//  UIGestureRecognizer+Extend.h
//  kActivity
//
//  Created by zhaoke on 16/10/26.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (Extend)

- (instancetype)initWithActionBlock:(void(^)(id sender))block;
- (void)addActionBlock:(void(^)(id sender))block;
- (void)removeAllActionBlocks;

@end
