//
//  tweetlistModel.h
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tweetlistModel : NSObject

@property(nonatomic,strong)NSString *pubDate;
@property(nonatomic,strong)NSString *body;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *commentCount;
@property(nonatomic,strong)NSString *portrait;


@end
