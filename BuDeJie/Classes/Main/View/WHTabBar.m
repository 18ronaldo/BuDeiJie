//
//  WHTabBar.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/29.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHTabBar.h"
#import "UIView+Frame.h"

@interface WHTabBar ()

@property (nonatomic,weak) UIButton *publishBtn;
/** 上一次点击的按钮 **/
@property (nonatomic,weak) UIControl *previousClickedTabBarButton;

@end

@implementation WHTabBar

#pragma mark - 发布图片按钮懒加载
- (UIButton *)publishBtn{
    if (_publishBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"]  forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        //按钮的尺寸自适应
        [btn sizeToFit];
        [self addSubview:btn];
        _publishBtn = btn;
    }
    return _publishBtn;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //NSLog(@"%@",self.subviews);
    //调整tabBarButton位置
    CGFloat btnW = self.wh_width / (self.items.count + 1);
    CGFloat btnH = self.wh_height;
    CGFloat x = 0;
    int i = 0;
    //私有类：打印出来有那个类，但是敲出来没有，说明这个类是系统的私有类
    //遍历子控件  调整布局
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            //设置previousClickedTabBarButton默认值为最前面的精华按钮
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarButton;
            }
            
            //NSLog(@"%@",tabBarButton);
            if (i == 2) {
                i += 1;
            }
            x = i * btnW;
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
            //监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    //调整发布按钮位置
    self.publishBtn.center = CGPointMake(self.wh_width * 0.5, self.wh_height * 0.5);
    
}
- (void)tabBarButtonClick:(UIControl *)tabBarButton{
    
    if (self.previousClickedTabBarButton == tabBarButton) {
        //发出通知，告诉外界tabBarButton被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:WHTabBarButtonRepeatClickNotification object:nil];
    }
    self.previousClickedTabBarButton = tabBarButton;
}

@end
