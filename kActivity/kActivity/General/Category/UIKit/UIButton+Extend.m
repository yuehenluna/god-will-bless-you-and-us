//
//  UIButton+Extend.m
//  kActivity
//
//  Created by zhaoke on 16/10/26.
//  Copyright © 2016年 zk. All rights reserved.
//

#import "UIButton+Extend.h"
#import "UIControl+Extend.h"

@implementation UIButton (Extend)

- (void)setButtonAction:(void(^)(id sender))action {
    [self addBlockForControlEvents:UIControlEventTouchUpInside block:action];
}

@end
