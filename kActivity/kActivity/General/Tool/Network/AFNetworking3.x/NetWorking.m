//
//  NetWorking.m
//  AFNetworking3.x封装
//
//  Created by zhaoke on 16/8/31.
//  Copyright © 2016年 zk. All rights reserved.
//

#import "NetWorking.h"

@implementation NetWorking

+ (AFHTTPSessionManager *)sessionManager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.reachabilityManager = reachabilityManager;
    [sessionManager.reachabilityManager startMonitoring];
    sessionManager.requestSerializer.HTTPShouldHandleCookies = YES;
    sessionManager.requestSerializer.timeoutInterval = 30.f;
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    return sessionManager;
}
/**
 * -- 清除缓存数据
 */
+ (void)clearCaches {
    
}
/**
 * -- get 无缓存/自定义缓存方法
 */
+ (NSURLSessionTask *)getURL:(NSString *)urlStr dic:(NSDictionary *)parameter success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure {
    return [self getURL:urlStr dic:parameter cachePolicy:RequestDontCacheData success:success failure:failure];
}
+ (NSURLSessionTask *)getURL:(NSString *)urlStr dic:(NSDictionary *)parameter cachePolicy:(RequestCachePolicy)cachePolicy success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure {
    return [self requestURLString:urlStr parameters:parameter requestType:Type_GET cachePolicy:cachePolicy success:success failure:failure];
}
/**
 * -- post 无缓存/自定义缓存
 */
+ (NSURLSessionTask *)postURL:(NSString *)urlStr dic:(NSDictionary *)parameter success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure {
    return [self postURL:urlStr dic:parameter cachePolicy:RequestDontCacheData success:success failure:failure];
}
+ (NSURLSessionTask *)postURL:(NSString *)urlStr dic:(NSDictionary *)parameter cachePolicy:(RequestCachePolicy)cachePolicy success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure {
    return [self requestURLString:urlStr parameters:parameter requestType:Type_POST cachePolicy:cachePolicy success:success failure:failure];
}

+ (NSURLSessionTask *)requestURLString:(NSString *)URLString parameters:(id)parameters requestType:(RequestType)type cachePolicy:(RequestCachePolicy)cachePolicy success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure {
    
    NSString *cacheKey = [self cacheKeyWithURLString:URLString parameters:parameters];
    id cacheResponseObject = [NetWorkingCache getNetworkingCacheForKey:cacheKey];
    switch (cachePolicy) {
        case RequestDontCacheData:
            break;
        case RequestCacheDataThenLoad:{
            if (success && cacheResponseObject) {
                success(nil, cacheResponseObject);
            }
        }
            break;
        case RequestIgnoreLocalCacheData:
            break;
        case ReqeustCacheDataElseLoad:{
            if (success && cacheResponseObject) {
                success(nil,cacheResponseObject);
                return nil;
            }
        }
            break;
        case ReqeustCacheDataElseDontLoad:{
            if (success && cacheResponseObject) {
                success(nil,cacheResponseObject);
            }
            return nil;
        }
            break;
        default:
            break;
    }

    AFHTTPSessionManager *manager = [self sessionManager];
    switch (type) {
        case Type_GET:{
            return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if(success){
                    success(task, responseObject);
                }
                if(cachePolicy != RequestDontCacheData){
                    [NetWorkingCache saveNetworkingCache:responseObject forKey:cacheKey];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failure){
                    failure(task, error);
                }
            }];
        }
            break;
        case Type_POST:{
            return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if(success){
                    success(task, responseObject);
                }
                if(cachePolicy != RequestDontCacheData){
                    [NetWorkingCache saveNetworkingCache:responseObject forKey:cacheKey];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failure){
                    failure(task, error);
                }
            }];
        }
            break;
        default:
            break;
    }
}
/**
 * -- 上传图片 
 */
+ (NSURLSessionTask *)uploadURL:(NSString *)urlStr parameters:(id)parameters images:(NSArray<UIImage *>*)images fileNmae:(NSString *)fileName name:(NSString *)name mimeType:(NSString *)mimeType progress:(NetworkingProgress)progress success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure {
    AFHTTPSessionManager *manager = [self sessionManager];
    return [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 添加图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = UIImageJPEGRepresentation(obj, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,idx,mimeType?mimeType:@"image/jpeg"] mimeType:mimeType?mimeType:@"image/jpeg"];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progress){
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(task, error);
        }
    }];
}
+ (NSURLSessionTask *)uploadURL:(NSString *)urlStr parameters:(id)parameters image:(UIImage *)image fileNmae:(NSString *)fileName name:(NSString *)name mimeType:(NSString *)mimeType progress:(NetworkingProgress)progress success:(NetworkResponseSuccess)success failure:(NetworkResponseFailure)failure {
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    if(!fileName || ![fileName isKindOfClass:[NSString class]] || fileName.length == 0) {
        NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        fileName = [NSString stringWithFormat:@"%@.jpg",str];
    }
    if(!mimeType || ![mimeType isKindOfClass:[NSString class]] || mimeType.length == 0) {
        mimeType = @"application/octet-stream";
    }
    AFHTTPSessionManager *manager = [self sessionManager];
    return [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(task, error);
        }
    }];
    
}
/**
 * -- 下载
 */
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL parameters:(id)parameters filePath:(NSString *)filePath progress:(NetworkingProgress)progress successs:(void(^)(NSString *filePath))success failure:(NetworkResponseFailure)failure {
    AFHTTPSessionManager *manager = [self sessionManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if(progress){
            progress(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *downloadPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:filePath?filePath:@"Download"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePathName = [downloadPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:filePathName];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(failure){
            failure(nil, error);
        }
    }];
    [downloadTask resume];
    return downloadTask;
}
+ (NSString *)cacheKeyWithURLString:(NSString *)URLString parameters:(id)parameters {
    NSString *cacheKey = [NSString stringWithFormat:@"%@",URLString];
    if (parameters) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        cacheKey = [NSString stringWithFormat:@"%@%@",cacheKey,jsonStr];
    }
    return cacheKey;
}
@end
