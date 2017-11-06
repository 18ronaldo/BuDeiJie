//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/28.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageWithOriginalWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (instancetype)wh_circleImage{
    //1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置裁剪区域
    [path addClip];
    //4.画图片
    [self drawAtPoint:CGPointZero];
    //5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)wh_circleImageWithNamed:(NSString *)name{
    return [[self imageNamed:name] wh_circleImage];
}

@end
