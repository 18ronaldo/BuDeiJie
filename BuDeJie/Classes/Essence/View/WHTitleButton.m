//
//  WHTitleButton.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/9.
//  Copyright © 2017年 ronaldo. All rights reserved.
//
/*
    特定构造方法
    1.后面带有NS_DESIGNATED_INITIALIZER的方法，就是特定构造方法
    2.子类如果重写了父类的【特定构造方法】，那么必须用super调用父类的【特定构造方法】，不然会出现警告
 */


#import "WHTitleButton.h"

@implementation WHTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        //文字颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    //只要重写这个方法，按钮就无法进入highlighted状态
}

@end
