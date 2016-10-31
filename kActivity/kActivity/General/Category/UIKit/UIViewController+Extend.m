//
//  UIViewController+Extend.m
//  kActivity
//
//  Created by zhaoke on 16/10/26.
//  Copyright © 2016年 zk. All rights reserved.
//

#import "UIViewController+Extend.h"
#import "UILabel+Extend.h"

@implementation UIViewController (Extend)

- (void)popToRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)setNaviTitle:(NSString *)title withColor:(UIColor  *)color {
    UILabel *label = [UILabel naviLabelWithTitle:title color:color];
    CGFloat fontSize;
    if(isIphone4 || isIphone5) fontSize = 17.0f;
    else if(isIphone6) fontSize = 18.0f;
    else if(isIphone6plus) fontSize = 20.0f;
    label.font = [UIFont systemFontOfSize:fontSize];
    self.navigationItem.titleView = label;
}

@end
