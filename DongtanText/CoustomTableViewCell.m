//
//  CoustomTableViewCell.m
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import "CoustomTableViewCell.h"
#import "NSString+Height.h"

@implementation CoustomTableViewCell

{
    UIImageView *imageView;
    UILabel *label;
    UILabel *detailLabel;
    UILabel *pinglun;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

-(void)addContentView{
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 20;
    [self.contentView addSubview:imageView];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 10, kScreenSize.width - 90, 20)];
    label.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:label];
    
    detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10, CGRectGetMaxY(label.frame), kScreenSize.width - 90, 0)];
    detailLabel.font = [UIFont systemFontOfSize:14.0];
    detailLabel.numberOfLines = 0;
    [self.contentView addSubview:detailLabel];
    
    pinglun = [[UILabel alloc] initWithFrame:CGRectMake( kScreenSize.width - 120, 0, 100, 20)];
    pinglun.textAlignment = NSTextAlignmentRight;
    pinglun.textColor = [UIColor grayColor];
    pinglun.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:pinglun];
}

-(void)setModel:(tweetlistModel *)model{
    _model = model;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.portrait]];
    label.text = model.author;
    float h = [NSString getHeightOfString:model.body withFont:[UIFont systemFontOfSize:14.0]];
    detailLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 10, CGRectGetMaxY(label.frame), kScreenSize.width - 90, h + 10);
    detailLabel.text = model.body;
    pinglun.frame = CGRectMake(kScreenSize.width - 120, CGRectGetMaxY(detailLabel.frame), 100, 20);
    pinglun.text = [NSString stringWithFormat:@"评论数：%@",model.commentCount];
}

@end
