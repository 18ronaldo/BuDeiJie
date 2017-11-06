//
//  WHFastLoginView.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/6.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHFastLoginView.h"

@implementation WHFastLoginView

+ (instancetype)fastLoginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
