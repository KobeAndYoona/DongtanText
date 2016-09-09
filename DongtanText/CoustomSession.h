//
//  CoustomSession.h
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CoustomSession : AFHTTPSessionManager

+(instancetype)shareSession;

@end
