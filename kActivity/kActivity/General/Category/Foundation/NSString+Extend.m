//
//  NSString+Extend.m
//  kActivity
//
//  Created by zhaoke on 16/8/28.
//  Copyright © 2016年 zk. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSNumber+yyExtend.h"

@implementation NSString (Extend)
- (NSString *)urlEncode {
    [NSCharacterSet URLQueryAllowedCharacterSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
- (NSString *)urlDecode {
    return [self stringByRemovingPercentEncoding];
}
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (uint32_t)strlen(cStr),result);
    NSMutableString *hash =[NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
- (BOOL)allSpaceInString {
    if(self.length <= 0){
        return YES;
    }
    NSString *regx = [NSString stringWithFormat:@"\\s{%lu}",(unsigned long)self.length];
    NSPredicate *allSpace = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [allSpace evaluateWithObject:self];
}
- (BOOL)validEmail {
    NSString *regex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    BOOL rect = [self validateByRegex:regex];
    return rect;
}
- (BOOL)checkPhoneNumInput {
    if(self.length <= 0){
        return NO;
    }
    if(self.length > 14 || self.length < 11){
        return NO;
    }
    NSString *mobile = [self substringFromIndex:self.length-11];
    NSString *rgex = @"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",rgex];
    return [phoneTest evaluateWithObject:mobile];
}
- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}
- (BOOL)validateByRegex:(NSString *)regexStr {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    BOOL rect = [predicate evaluateWithObject:self];
    return rect;
}
- (NSString *)validMobile {
    if(self.length < 11){
        return @"手机号长度不能小于11位";
    } else {
        //移动号正则表达式
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
         //联通号正则表达式
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        //电信号正则表达式
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的电话号码";
        }
    }
}
- (NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}
- (NSData *)dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
- (NSRange)rangeOfAll {
    return NSMakeRange(0, self.length);
}
- (id)jsonValueDecoded {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:[self dataValue] options:NSJSONReadingAllowFragments error:&error];
    if(error){
        NSLog(@"jsonValueDecoded error:%@",error);
    }
    return value;
}

- (NSString *)thisYear{
    return [NSString stringWithFormat:@"%ld",[[self thisDateComponent] year]];
}
- (NSString *)thisMonth{
    return [NSString stringWithFormat:@"%ld",[[self thisDateComponent] month]];
}
- (NSString *)thisDay{
    return [NSString stringWithFormat:@"%ld",[[self thisDateComponent] day]];
}
- (NSDateComponents *)thisDateComponent {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    return components;
}
- (NSDate *)dateFromString {
    NSTimeInterval timeInterval = self.floatValue;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}
- (NSString *)timestampToTimeStringWithFormatString:(NSString *)formatString {
    NSString *str = nil;
    if(self.length > 10){
        str = [self substringToIndex:10];
    } else {
        str = self;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:formatString];
    return [formate stringFromDate:date];
}
- (CGFloat)heightWithMaxWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    return [self stringSizeForMAXWidth:widthValue andFont:font].height;
}
- (CGSize)stringSizeForMAXWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGFloat result = 0;
    CGSize size;
    if (self.length>0) {
        CGRect frame = [self boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);
        result = MAX(size.height, result);
    }
    return CGSizeMake(size.width, result);
}
- (CGFloat)realHeightForStringWithWidth:(CGFloat)width font:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height+1;
}

@end
