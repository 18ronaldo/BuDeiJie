//
//  UITextField+Placeholder.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/6.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    //给成员属性赋值  runtime给系统的类添加成员属性
    //添加成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //设置占位文字颜色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
    
}
- (UIColor *)placeholderColor{
    return objc_getAssociatedObject(self, @"placeholderColor");
}
#pragma mark - 设置占位文字/占位文字颜色
- (void)setWH_Placeholder:(NSString *)placeholder{
    [self setWH_Placeholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}

+ (void)load{
    
    //交换方法，只交换一次
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setWH_PlaceholderMethod = class_getInstanceMethod(self, @selector(setWH_Placeholder:));
    method_exchangeImplementations(setPlaceholderMethod, setWH_PlaceholderMethod);
    
}

@end
