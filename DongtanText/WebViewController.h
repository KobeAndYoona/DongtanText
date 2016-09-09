//
//  WebViewController.h
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property(nonatomic,strong)void(^getCodeBlock)(NSString *code);

@end
