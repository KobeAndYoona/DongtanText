//
//  MyTool.m
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import "MyTool.h"
#import "CoustomSession.h"

@implementation MyTool

-(NSURLSessionTask *)getTaskWithString:(NSString *)parmer{
    return [[CoustomSession shareSession] GET:[kURLStr stringByAppendingString:parmer] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.completeRequest(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.debugDescription);
    }];
}

-(NSURLSessionTask *)postTaskWithString:(NSDictionary *)parmerDic{
    return [[CoustomSession shareSession] POST:[kURLStr stringByAppendingString:parmerDic[@"method"]] parameters:parmerDic[@"parmer"] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
