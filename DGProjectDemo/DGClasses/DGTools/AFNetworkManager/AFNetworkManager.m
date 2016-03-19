//
//  AFNetworkManager.m
//  DGProjectDemo
//
//  Created by Gavin on 16/3/18.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "AFNetworkManager.h"

@implementation AFNetworkManager

#pragma mark - GET Method
void requestGET(NSString *requestUrl,NSDictionary *parameter,responseSuccessful successfulBlock,responseError errorBlock)
{
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_responseSuccessful != successfulBlock)
    {
        r->block_responseSuccessful = successfulBlock;
    }
    if (r->block_responseError != errorBlock)
    {
        r->block_responseError = errorBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFCompoundResponseSerializer serializer];
    [session GET:[HostUrl stringByAppendingString:requestUrl] parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        r->block_responseSuccessful(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_responseError(error);
    }];
}

#pragma mark - POST Method
void requestPost(NSString *requestUrl,NSDictionary *parameter,responseSuccessful successfulBlock,responseError errorBlock)
{
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_responseSuccessful != successfulBlock)
    {
        r->block_responseSuccessful = successfulBlock;
    }
    if (r->block_responseError != errorBlock)
    {
        r->block_responseError = errorBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFCompoundResponseSerializer serializer];
    [session POST:[HostUrl stringByAppendingString:requestUrl] parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        r->block_responseSuccessful(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_responseError(error);
    }];
    
}

void requestPostBody(NSString *requestUrl,NSDictionary *parameter,requestBody bodyBlock,responseSuccessful successfulBlock,responseError errorBlock)
{
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_responseSuccessful != successfulBlock)
    {
        r->block_responseSuccessful = successfulBlock;
    }
    if (r->block_responseError != errorBlock)
    {
        r->block_responseError = errorBlock;
    }
    
    r->block_requestBody = bodyBlock;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFCompoundResponseSerializer serializer];
    [session POST:[HostUrl stringByAppendingString:requestUrl] parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        r->block_requestBody (formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        r->block_responseSuccessful(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_responseError(error);
    }];
}

#pragma mark - 下载文件
void downloadFileRequestPost(NSString *requestUrl,NSString *saveToPath,NSDictionary *parameter,responseSuccessful successfulBlock,responseError errorBlock)
{
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_responseSuccessful != successfulBlock)
    {
        r->block_responseSuccessful = successfulBlock;
    }
    if (r->block_responseError != errorBlock)
    {
        r->block_responseError = errorBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    NSMutableURLRequest *downloadRequest = [session.requestSerializer requestWithMethod:@"POST" URLString:requestUrl parameters:parameter error:nil];
    
    [session downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (r->block_requestProgress) {
            r->block_requestProgress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (r->block_responseSuccessful) {
            r->block_responseSuccessful(filePath.absoluteString);
        }
    }];
}

#pragma mark - 上传文件
void updateFileWithURL(NSString*url,NSDictionary*paramsDict,UploadFileModel *uploadParam,responseSuccessful successfulBlock,responseError errorBlock){
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_responseSuccessful != successfulBlock)
    {
        r->block_responseSuccessful = successfulBlock;
    }
    if (r->block_responseError != errorBlock)
    {
        r->block_responseError = errorBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    session.requestSerializer.timeoutInterval = 20;
    
    [session POST:url parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *fileData = uploadParam.data;
        [formData appendPartWithFileData:fileData
                                    name:uploadParam.name
                                fileName:uploadParam.fileName mimeType:uploadParam.fileType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        r->block_requestProgress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        r->block_responseSuccessful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_responseError(error);
    }];
    
}


#pragma mark - 上传一张图片
void updateOneImgWithURL(NSString*url,NSDictionary*paramsDict,UploadFileModel *uploadParam,responseSuccessful successfulBlock,responseError errorBlock){
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_responseSuccessful != successfulBlock)
    {
        r->block_responseSuccessful = successfulBlock;
    }
    if (r->block_responseError != errorBlock)
    {
        r->block_responseError = errorBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    session.requestSerializer.timeoutInterval = 20;
    
    [session POST:url parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imgData = uploadParam.data;
        [formData appendPartWithFileData:imgData
                                    name:uploadParam.name
                                fileName:uploadParam.fileName mimeType:uploadParam.fileType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        r->block_requestProgress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        r->block_responseSuccessful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_responseError(error);
    }];
    
}

#pragma mark - 上传多张图片
void updateMoreImgWithURL(NSString*url,NSDictionary*paramsDict,NSMutableArray*imgDataArr,UploadFileModel*uploadParam,responseSuccessful successfulBlock,responseError errorBlock){
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_responseSuccessful != successfulBlock)
    {
        r->block_responseSuccessful = successfulBlock;
    }
    if (r->block_responseError != errorBlock)
    {
        r->block_responseError = errorBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    session.requestSerializer.timeoutInterval = 20;
    
    [session POST:url parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(int i = 0;i<imgDataArr.count;i++){
            NSData *imgData = imgDataArr[i];
            [formData appendPartWithFileData:imgData
                                        name:[NSString stringWithFormat:@"%@%d",uploadParam.name,i+1]
                                    fileName:uploadParam.fileName mimeType:uploadParam.fileType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        r->block_requestProgress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        r->block_responseSuccessful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_responseError(error);
    }];
    
}

@end
