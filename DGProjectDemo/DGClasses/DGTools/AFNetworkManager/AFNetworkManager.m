//
//  AFNetworkManager.m
//  DGProjectDemo
//
//  Created by Gavin on 16/3/18.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "AFNetworkManager.h"

@implementation AFNetworkManager

void requestGET(NSString *requestUrl,NSDictionary *parameter,requestSuccessful successfulBlock,requestError errorBlock)
{
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFCompoundResponseSerializer serializer];
    [session GET:[HostUrl stringByAppendingString:requestUrl] parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        r->block_requestSuccessful(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_requestError(error);
    }];
}


void requestPost(NSString *requestUrl,NSDictionary *parameter,requestSuccessful successfulBlock,requestError errorBlock)
{
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFCompoundResponseSerializer serializer];
    [session POST:[HostUrl stringByAppendingString:requestUrl] parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        r->block_requestSuccessful(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_requestError(error);
    }];
    
}

void requestPostBody(NSString *requestUrl,NSDictionary *parameter,requestBody bodyBlock,requestSuccessful successfulBlock,requestError errorBlock)
{
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
    }
    
    r->block_requestBody = bodyBlock;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFCompoundResponseSerializer serializer];
    [session POST:[HostUrl stringByAppendingString:requestUrl] parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        r->block_requestBody (formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        r->block_requestSuccessful(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_requestError(error);
    }];
}

#pragma mark - 下载文件
void downloadFileRequestPost(NSString *requestUrl,NSDictionary *parameter,requestSuccessful successfulBlock,requestError errorBlock)
{
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFCompoundResponseSerializer serializer];
    [session POST:requestUrl parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        r->block_requestProgress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //此处待补充（下载接收文件数据流）
//        id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        r->block_requestSuccessful(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_requestError(error);
    }];
    
}

#pragma mark - 上传文件
void updateFileWithURL(NSString*url,NSDictionary*paramsDict,UploadFileModel *uploadParam,requestSuccessful successfulBlock,requestError errorBlock){
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
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
        r->block_requestProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        r->block_requestSuccessful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_requestError(error);
    }];
    
}


#pragma mark - 上传一张图片
void updateOneImgWithURL(NSString*url,NSDictionary*paramsDict,UploadFileModel *uploadParam,requestSuccessful successfulBlock,requestError errorBlock){
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
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
        r->block_requestProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        r->block_requestSuccessful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_requestError(error);
    }];
    
}

#pragma mark - 上传多张图片
void updateMoreImgWithURL(NSString*url,NSDictionary*paramsDict,NSMutableArray*imgDataArr,UploadFileModel*uploadParam,requestSuccessful successfulBlock,requestError errorBlock){
    
    AFNetworkManager *r = [AFNetworkManager new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
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
        r->block_requestProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        r->block_requestSuccessful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        r->block_requestError(error);
    }];
    
}

@end
