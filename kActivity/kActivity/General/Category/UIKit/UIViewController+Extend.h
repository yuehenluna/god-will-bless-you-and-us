//
//  UIViewController+Extend.h
//  kActivity
//
//  Created by zhaoke on 16/10/26.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extend)
/**
 *  --z push/pop
 */
- (void)popToRoot;
/**
 *  --z custom navigation
 */
- (void)setNaviTitle:(NSString *)title withColor:(UIColor  *)color;

@end
