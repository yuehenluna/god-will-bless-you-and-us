//
//  UINavigationController+Extend.h
//  kActivity
//
//  Created by zhaoke on 2016/11/18.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extend)

- (void)setBackgroundColor:(UIColor *)bgcolor textColor:(UIColor *)textcolor;
- (void)autoHidden;
- (UIViewController *)popToViewControllerOfClass:(Class)cls animated:(BOOL)animated;
- (UIViewController *)popToViewControllerOfClass:(Class)cls animated:(BOOL)animated competion:(void(^)())completion;

@end
