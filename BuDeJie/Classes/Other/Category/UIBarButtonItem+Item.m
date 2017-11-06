//
//  UIBarButtonItem+Item.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/29.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithnormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];//自适应
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}
+ (UIBarButtonItem *)itemWithnormalImage:(UIImage *)normalImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];//自适应
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}
+ (UIBarButtonItem *)backBtnWithnormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title{
    //设置导航条左边（返回）按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitle:title forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:normalImage forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton sizeToFit];//自适应
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);//按钮左移
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
@end
