//
//  WHTopic.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/15.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHTopic.h"

@implementation WHTopic

- (CGFloat)cellHeight{
    
    if (_cellHeight)    return _cellHeight;

    //文字的y值
    _cellHeight += 55;
    //文字的高度
    CGSize textMaxSize = CGSizeMake(WHScreenW - 2 * WHMargin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + WHMargin;
    //工具条
    _cellHeight += 35 + 2 * WHMargin;
    return _cellHeight;
    
}

@end
