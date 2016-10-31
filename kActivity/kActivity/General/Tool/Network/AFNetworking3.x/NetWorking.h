//
//  NetWorking.h
//  AFNetworking3.x封装
//
//  Created by zhaoke on 16/8/31.
//  Copyright © 2016年 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkingCache.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

/**
 * 网络状态
 */
typedef NS_ENUM(NSUInteger, NetworkingStatus) {
    NetworkingStatusUnknown,
    NetworkingStatusNotReachable,
    NetworkingStatusReachableViaWWAN,
    NetworkingStatusReachableViaWifi,
};
typedef void(^NetworkResponseSuccess)(NSURLSessionTask *task, id responseObject);
typedef void(^NetworkResponseFailure)(NSURLSessionTask *task, NSError *error);
// 缓存block
typedef void(^NetworkingCache)(id responseCache);
// 进度block
typedef void(^NetworkingProgress)(NSProgress *progress);
typedef void(^NetworkingStatusBlock)(NetworkingStatus status);
/**
 *  缓存方式
 */
typedef NS_ENUM(NSUInteger, RequestCachePolicy) {
    RequestDontCacheData = 0, // 不缓存，直接请求
    RequestCacheDataThenLoad, // 有缓存先返回缓存，同步请求数据
    RequestIgnoreLocalCacheData, //忽略缓存，重新请求
    ReqeustCacheDataElseLoad,  // 有缓存就用缓存，没有重新请求
    ReqeustCacheDataElseDontLoad,  //有缓存就用缓存，没有也不发送请求
};
/**
 *  请求方式
 */
typedef NS_ENUM(NSUInteger, RequestType) {
    Type_GET = 0,
    Type_POST,
};


@interface NetWorking : NSObject

//+ (AFHTTPSessionManager *)sessionManager;

/** 
 * -- 清除缓存数据
 */
+ (void)clearCaches;
/**
 * -- get 无缓存/自定义缓存方法
 */
+ (NSURLSessionTask *)getURL:(NSString *)urlStr dic:(NSDictionary *)parameter success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure;
+ (NSURLSessionTask *)getURL:(NSString *)urlStr dic:(NSDictionary *)parameter cachePolicy:(RequestCachePolicy)cachePolicy success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure;
/**
 * -- post 无缓存/自定义缓存
 */
+ (NSURLSessionTask *)postURL:(NSString *)urlStr dic:(NSDictionary *)parameter success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure;
+ (NSURLSessionTask *)postURL:(NSString *)urlStr dic:(NSDictionary *)parameter cachePolicy:(RequestCachePolicy)cachePolicy success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure;
/**
 * -- 上传图片
 */
+ (NSURLSessionTask *)uploadURL:(NSString *)urlStr parameters:(id)parameters images:(NSArray<UIImage *>*)images fileNmae:(NSString *)fileName name:(NSString *)name mimeType:(NSString *)mimeType progress:(NetworkingProgress)progress success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure;
+ (NSURLSessionTask *)uploadURL:(NSString *)urlStr parameters:(id)parameters image:(UIImage *)image fileNmae:(NSString *)fileName name:(NSString *)name mimeType:(NSString *)mimeType progress:(NetworkingProgress)progress success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure;
/**
 * -- 下载
 */
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL parameters:(id)parameters filePath:(NSString *)filePath progress:(NetworkingProgress)progress successs:(void(^)(NSString *filePath))success failure:(NetworkResponseFailure)failure;

@end

