//
//  UIBarButtonItem+Extend.h
//  kActivity
//
//  Created by zhaoke on 16/10/26.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extend)

- (void)setBarButtonActionBlock:(void(^)(id))block;

@end
