//
//  UIImage+Image.h
//  BuDeJie
//
//  Created by 王辉 on 2017/7/28.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (UIImage *)imageWithOriginalWithName:(NSString *)imageName;

- (instancetype)wh_circleImage;

+ (instancetype)wh_circleImageWithNamed:(NSString *)name;

@end
