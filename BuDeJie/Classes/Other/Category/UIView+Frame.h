//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by 王辉 on 2017/7/29.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    写分类：避免跟其他开发者产生冲突,加自己特殊的前缀
 */
@interface UIView (Frame)

@property CGFloat wh_width;
@property CGFloat wh_height;
@property CGFloat wh_x;
@property CGFloat wh_y;
@property CGFloat wh_centerX;
@property CGFloat wh_centerY;

@end
