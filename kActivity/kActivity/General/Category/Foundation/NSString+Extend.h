//
//  NSString+Extend.h
//  kActivity
//
//  Created by zhaoke on 16/8/28.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extend)

/**
 *  --z 字符串判断
 */
- (BOOL)validEmail;
- (BOOL)allSpaceInString;
- (BOOL)checkPhoneNumInput;
- (NSString *)validMobile;
- (NSString *)stringByTrim;
- (BOOL)validateByRegex:(NSString *)regexStr;
/**
 *  --z 编码，加密
 */
- (NSString *)urlEncode;
- (NSString *)urlDecode;
- (NSString *)md5;

/**
 *  --z 转换
 */
- (NSNumber *)numberValue;
- (NSData *)dataValue;
- (NSRange)rangeOfAll;
- (id)jsonValueDecoded;

- (NSString *)thisYear;
- (NSString *)thisMonth;
- (NSString *)thisDay;
- (NSDate *)dateFromString;
- (NSString *)timestampToTimeStringWithFormatString:(NSString *)formatString;
/**
 *  --z 其他
 */
- (CGFloat)heightWithMaxWidth:(CGFloat)widthValue andFont:(UIFont *)font;
- (CGSize)stringSizeForMAXWidth:(CGFloat)widthValue andFont:(UIFont *)font;
- (CGFloat)realHeightForStringWithWidth:(CGFloat)width font:(UIFont *)font; // 高度计算补偿1

@end
