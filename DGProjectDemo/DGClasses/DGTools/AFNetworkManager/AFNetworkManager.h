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

typedef void(^requestProgress) (NSProgress *downloadProgress);

typedef void(^requestSuccessful) (id dict);
typedef void(^requestError) (NSError *error);

@interface AFNetworkManager : NSObject
{
@public
    requestBody block_requestBody;
    
    requestProgress block_requestProgress;
    
    requestSuccessful block_requestSuccessful;
    requestError block_requestError;
}

/**
 *  GET 请求
 *
 *  @param requestUrl      请求地址URL
 *  @param parameter       请求参数
 *  @param successfulBlock 请求成功回调Block
 *  @param errorBlock      请求Error回调Block
 */
void requestGET(NSString *requestUrl,NSDictionary *parameter,requestSuccessful successfulBlock,requestError errorBlock);

/**
 *  Post 请求
 *
 *  @param requestUrl      请求地址URL
 *  @param parameter       请求参数
 *  @param successfulBlock 请求成功回调Block
 *  @param errorBlock      请求Error回调Block
 */
void requestPost(NSString *requestUrl,NSDictionary *parameter,requestSuccessful successfulBlock,requestError errorBlock);

/**
 *  上传文件
 *
 *  @param requestUrl      请求地址URL
 *  @param paramsDict      请求参数
 *  @param uploadParam     上传文件数据模型
 *  @param successfulBlock 上传成功回调Block
 *  @param errorBlock      上传Error回调Block
 */
void updateFileWithURL(NSString *requestUrl,NSDictionary *paramsDict,UploadFileModel *uploadParam,requestSuccessful successfulBlock,requestError errorBlock);
    
/**
 *  传送单张图片
 *
 *  @param requestUrl      请求地址URL
 *  @param paramsDict      请求参数
 *  @param uploadParam     上传文件数据模型
 *  @param successfulBlock 上传成功回调Block
 *  @param errorBlock      上传Error回调Block
 */
void updateOneImgWithURL(NSString *requestUrl,NSDictionary *paramsDict,UploadFileModel *uploadParam,requestSuccessful successfulBlock,requestError errorBlock);

/**
 *  传送多张图片
 *
 *  @param requestUrl      请求地址URL
 *  @param paramsDict      请求参数
 *  @param uploadParam     上传文件数据模型
 *  @param successfulBlock 上传成功回调Block
 *  @param errorBlock      上传Error回调Block
 */
void updateMoreImgWithURL(NSString *requestUrl,NSDictionary *paramsDict,NSMutableArray *imgDataArr,UploadFileModel *uploadParam,requestSuccessful successfulBlock,requestError errorBlock);

@end
