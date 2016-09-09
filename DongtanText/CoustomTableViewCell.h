//
//  CoustomTableViewCell.h
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweetlistModel.h"

@interface CoustomTableViewCell : UITableViewCell

@property(nonatomic,strong)tweetlistModel *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
