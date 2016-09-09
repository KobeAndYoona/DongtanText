//
//  CoustomSession.m
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import "CoustomSession.h"

@implementation CoustomSession

+(instancetype)shareSession{
    static CoustomSession *session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [CoustomSession manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];;
    });
    return session;
}

@end
