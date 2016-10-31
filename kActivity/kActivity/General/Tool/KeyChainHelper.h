//
//  KeyChainHelper.h
//  News
//
//  Created by MBankAPP on 15/1/14.
//
//

#import <Foundation/Foundation.h>

@interface KeyChainHelper : NSObject

+ (BOOL)deleteKeychain:(NSString *)identifier;
+ (BOOL)updateKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier;
+ (BOOL)createKeychainValueData:(NSString *)value forIdentifier:(NSString *)identifier;
+ (NSData *)searchKeychain:(NSString *)identifier;

@end
