//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/29.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setWh_width:(CGFloat)wh_width{
    CGRect rect = self.frame;
    rect.size.width = wh_width;
    self.frame = rect;
}
- (CGFloat)wh_width{
    return self.frame.size.width;
}
- (void)setWh_height:(CGFloat)wh_height{
    CGRect rect = self.frame;
    rect.size.height = wh_height;
    self.frame = rect;
}
- (CGFloat)wh_height{
    return self.frame.size.height;
}
- (void)setWh_x:(CGFloat)wh_x{
    CGRect rect = self.frame;
    rect.origin.x = wh_x;
    self.frame = rect;
}
- (CGFloat)wh_x{
    return self.frame.origin.x;
}
- (void)setWh_y:(CGFloat)wh_y{
    CGRect rect = self.frame;
    rect.origin.y = wh_y;
    self.frame = rect;
}
- (CGFloat)wh_y{
    return self.frame.origin.y;
}
- (void)setWh_centerX:(CGFloat)wh_centerX{
    CGPoint center = self.center;
    center.x = wh_centerX;
    self.center = center;
}
- (CGFloat)wh_centerX{
    return self.center.x;
}
- (void)setWh_centerY:(CGFloat)wh_centerY{
    CGPoint center = self.center;
    center.y =wh_centerY;
    self.center = center;
}
- (CGFloat)wh_centerY{
    return self.center.y;
}

@end
