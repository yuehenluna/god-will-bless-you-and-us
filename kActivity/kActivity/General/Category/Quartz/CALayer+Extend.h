//
//  CALayer+Extend.h
//  kActivity
//
//  Created by zhaoke on 16/10/27.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CALayer (Extend)

- (void)setLayerShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;
- (void)removeAllSublayers;

@end
