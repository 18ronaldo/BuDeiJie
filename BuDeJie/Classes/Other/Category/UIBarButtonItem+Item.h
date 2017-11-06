//
//  UIBarButtonItem+Item.h
//  BuDeJie
//
//  Created by 王辉 on 2017/7/29.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

//快速创建UIBarButtonItem
+ (UIBarButtonItem *)itemWithnormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithnormalImage:(UIImage *)normalImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backBtnWithnormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

@end
