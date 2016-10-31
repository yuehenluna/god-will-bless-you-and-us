//
//  ZKMainHeader.h
//  kActivity
//
//  Created by zhaoke on 16/8/18.
//  Copyright © 2016年 zk. All rights reserved.
//

#ifndef ZKMainHeader_h
#define ZKMainHeader_h

#pragma mark --- General define ----

#pragma mark - frame

#define _kScreenWidth [UIScreen mainScreen].bounds.size.width
#define _kScreenHeight [UIScreen mainScreen].bounds.size.height
#define isIphone4 _kScreenWidth == 480
#define isIphone5 _kScreenWidth == 568
#define isIphone6 _kScreenWidth == 667
#define isIphone6plus _kScreenWidth == 736

#pragma mark - color

#define RGBColor(a, b, c) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:1]
#define RGBAColor(a, b, c, d) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:(d)]
#define hexColor(colorV) [UIColor colorWithHexColorString:@#colorV]
#define hexColorAlpha(colorV,a) [UIColor colorWithHexColorString:@#colorV alpha:a];


#define _kMainWindow [[UIApplication sharedApplication].keyWindow


#pragma mark --- 单独文件的define -----

#define Degress_to_radians(d) (d * M_PI / 180)

#define TrigNum (180)     //一圈触发次数
#define CicleNum (90)     //半圈步数
#define TrigInterval (1)  //触发间隔
#define IgnoreNum (2)     //忽略步数


#endif /* ZKMainHeader_h */
