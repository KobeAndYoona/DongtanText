//
//  NSString+Height.m
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import "NSString+Height.h"

@implementation NSString (Height)

+(CGFloat)getHeightOfString:(NSString *)string withFont:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kScreenSize.width-90, MAX_CANON) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    CGFloat w = rect.size.height;
    return w;
}

@end
