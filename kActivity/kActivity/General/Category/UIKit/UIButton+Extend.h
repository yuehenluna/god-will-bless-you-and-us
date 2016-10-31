//
//  UIButton+Extend.h
//  kActivity
//
//  Created by zhaoke on 16/10/26.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extend)

- (void)setButtonAction:(void(^)(id sender))action;

@end
