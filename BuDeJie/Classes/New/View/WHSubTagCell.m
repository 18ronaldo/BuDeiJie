//
//  WHSubTagCell.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/1.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHSubTagCell.h"
#import "WHSubTagItem.h"
#import <UIImageView+WebCache.h>

@interface WHSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;


@end

@implementation WHSubTagCell

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -=1;
    [super setFrame:frame];
}

- (void)setItem:(WHSubTagItem *)item{
    
    _item = item;
    //设置内容
    _nameView.text = item.theme_name;
    
    [self resolveNum];
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //1.开启图形上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //3.设置裁剪区域
        [path addClip];
        //4.画图片
        [image drawAtPoint:CGPointZero];
        //5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //6.关闭上下文
        UIGraphicsEndImageContext();
        
        _iconView.image = image;
    }];
    
}
- (void)resolveNum{
    //判断下有没有>10000
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_item.sub_number];
    NSInteger num = _item.sub_number.integerValue;
    if ( num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numView.text = numStr;
}

/*
 把头像变成圆角:1.设置头像圆角 2.裁剪图片(生成新的图片 -> 图形上下文才能够生成新图片）
 处理数字
 */
//从xib加载就会调用
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置头像圆角，IOS9苹果修复
//    _iconView.layer.cornerRadius = 30;
//    _iconView.layer.masksToBounds = YES;
//    self.layoutMargins = UIEdgeInsetsZero;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
