//
//  AFNetworkManager.h
//  DGProjectDemo
//
//  Created by Gavin on 16/3/18.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UploadFileModel.h"

#define HostUrl @"http://192.168.1.100:8080/test/"

typedef void(^requestBody) (id<AFMultipartFormData> formData);

typedef void(^requestProgress) (int64_t bytes, int64_t totalBytes);

typedef void(^responseSuccessful) (id response);
typedef void(^responseError) (NSError *error);

@interface AFNetworkManager : NSObject
{
@public
    requestBody         block_requestBody;
    
    requestProgress     block_requestProgress;
    
    responseSuccessful  block_responseSuccessful;
    responseError       block_responseError;
}

/**
 *  GET 请求
 *
 *  @param requestUrl      请求地址URL
 *  @param parameter       请求参数
 *  @param successfulBlock 请求成功回调Block
 *  @param errorBlock      请求Error回调Block
 */
void requestGET(NSString *requestUrl,NSDictionary *parameter,responseSuccessful successfulBlock,responseError errorBlock);

/**
 *  Post 请求
 *
 *  @param requestUrl      请求地址URL
 *  @param parameter       请求参数
 *  @param successfulBlock 请求成功回调Block
 *  @param errorBlock      请求Error回调Block
 */
void requestPost(NSString *requestUrl,NSDictionary *parameter,responseSuccessful successfulBlock,responseError errorBlock);
/**
 *  Post 请求
 *
 *  @param requestUrl      请求地址URL
 *  @param parameter       请求参数
 *  @param bodyBlock       Body
 *  @param successfulBlock 请求成功回调Block
 *  @param errorBlock      请求Error回调Block
 */
void requestPostBody(NSString *requestUrl,NSDictionary *parameter,requestBody bodyBlock,responseSuccessful successfulBlock,responseError errorBlock);

/**
 *  下载文件
 *
 *  @param requestUrl      请求地址URL
 *  @param saveToPath      保存文件地址
 *  @param parameter       请求参数
 *  @param successfulBlock 下载文件成功回调Block
 *  @param errorBlock      下载文件失败回调Block
 */
void downloadFileRequestPost(NSString *requestUrl,NSString *saveToPath,NSDictionary *parameter,responseSuccessful successfulBlock,responseError errorBlock);
/**
 *  上传文件
 *
 *  @param requestUrl      请求地址URL
 *  @param paramsDict      请求参数
 *  @param uploadParam     上传文件数据模型
 *  @param successfulBlock 上传成功回调Block
 *  @param errorBlock      上传Error回调Block
 */
void updateFileWithURL(NSString *requestUrl,NSDictionary *paramsDict,UploadFileModel *uploadParam,responseSuccessful successfulBlock,responseError errorBlock);
    
/**
 *  传送单张图片
 *
 *  @param requestUrl      请求地址URL
 *  @param paramsDict      请求参数
 *  @param uploadParam     上传文件数据模型
 *  @param successfulBlock 上传成功回调Block
 *  @param errorBlock      上传Error回调Block
 */
void updateOneImgWithURL(NSString *requestUrl,NSDictionary *paramsDict,UploadFileModel *uploadParam,responseSuccessful successfulBlock,responseError errorBlock);

/**
 *  传送多张图片
 *
 *  @param requestUrl      请求地址URL
 *  @param paramsDict      请求参数
 *  @param uploadParam     上传文件数据模型
 *  @param successfulBlock 上传成功回调Block
 *  @param errorBlock      上传Error回调Block
 */
void updateMoreImgWithURL(NSString *requestUrl,NSDictionary *paramsDict,NSMutableArray *imgDataArr,UploadFileModel *uploadParam,responseSuccessful successfulBlock,responseError errorBlock);

@end
