//
//  KeyChainHelper.m
//  News
//
//  Created by MBankAPP on 15/1/14.
//
//

#import "KeyChainHelper.h"

@implementation KeyChainHelper

+ (NSMutableDictionary *)createSearchDicionary:(NSString *)identifier
{
    NSMutableDictionary *searchDic = [[NSMutableDictionary alloc] initWithCapacity:12];
    NSData *searchData = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    
    [searchDic setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [searchDic setObject:searchData forKey:(__bridge id<NSCopying>)(kSecAttrAccount)];
    
    return searchDic;
}

+ (NSData *)searchKeychain:(NSString *)identifier
{
    NSMutableDictionary *searchDic = [self createSearchDicionary:identifier];
    [searchDic setObject:(id)kCFBooleanTrue forKey:(__bridge id<NSCopying>)(kSecReturnData)];
    
    CFDataRef resultRef = nil;
    
    OSStatus status =
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDic, (CFTypeRef *)&resultRef);
    
    if (status == errSecSuccess) {
        return (__bridge NSData *)resultRef;
    } else {
        NSLog(@"key chain search status:%ld", (long)status);
        return nil;
    }
}

+ (BOOL)createKeychainValueData:(NSString *)password forIdentifier:(NSString *)identifier
{
    NSMutableDictionary *searchDic = [self createSearchDicionary:identifier];
    NSData *ciperKeyData = [password dataUsingEncoding:NSUTF8StringEncoding];
    
    [searchDic setObject:ciperKeyData forKey:(__bridge id<NSCopying>)(kSecValueData)];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)searchDic, NULL);
    
    if (status == errSecSuccess)
        return YES;
    else {
        NSLog(@"key chain creat failed:%ld", (long)status);
        return NO;
    }
}

+ (BOOL)updateKeychainValue:(NSString *)ciperKey forIdentifier:(NSString *)identifier
{
    NSData *result = [self searchKeychain:identifier];
    if (!result) {
        return [self createKeychainValueData:ciperKey forIdentifier:identifier];
    }
    
    NSMutableDictionary *searchDic = [self createSearchDicionary:identifier];
    NSMutableDictionary *updateDic = [[NSMutableDictionary alloc] init];
    
    NSData *ciperKeyData = [ciperKey dataUsingEncoding:NSUTF8StringEncoding];
    [updateDic setObject:ciperKeyData forKey:(__bridge id<NSCopying>)(kSecValueData)];
    
    OSStatus status =
    SecItemUpdate((__bridge CFDictionaryRef)searchDic, (__bridge CFDictionaryRef)updateDic);
    
    if (status == errSecSuccess) {
        NSLog(@"update success");
        return YES;
    } else {
        NSLog(@"update key chain failed:%ld", (long)status);
        return NO;
    }
}

+ (BOOL)deleteKeychain:(NSString *)identifier
{
    NSMutableDictionary *searchDic = [self createSearchDicionary:identifier];
    OSStatus status = SecItemDelete((__bridge CFMutableDictionaryRef)searchDic);
    if (status == errSecSuccess)
        return YES;
    else
        return NO;
}

@end
