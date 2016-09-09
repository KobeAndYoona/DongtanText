//
//  MyTool.h
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTool : NSObject

@property(nonatomic,strong)void(^completeRequest)(NSURLSessionDataTask *task, id responseObject);

/**GET请求*/
-(NSURLSessionTask *)getTaskWithString:(NSString *)parmer;

/**POST请求*/
-(NSURLSessionTask *)postTaskWithString:(NSDictionary *)parmerDic;

@end
