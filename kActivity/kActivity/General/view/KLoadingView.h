//
//  KLoadingView.h
//  kActivity
//
//  Created by zhaoke on 16/8/21.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKMainHeader.h"

@interface KLoadingView2 : UIImageView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
- (void)startLoading;
- (void)endLoading;

@end

@interface KLoadingView : UIView

- (void)startLoadingAnimating;
- (void)stopLoadAnimating;

@end
