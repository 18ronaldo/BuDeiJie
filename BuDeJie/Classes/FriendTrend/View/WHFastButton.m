//
//  WHFastButton.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/6.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHFastButton.h"

@implementation WHFastButton

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置图片位置
    self.imageView.wh_y = 0;
    self.imageView.wh_centerX = self.wh_width * 0.5;
    //设置标题位置
    self.titleLabel.wh_y = self.wh_height - self.titleLabel.wh_height;
    //计算文字宽度，设置label的宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.wh_centerX = self.wh_width * 0.5;
    
}

@end
