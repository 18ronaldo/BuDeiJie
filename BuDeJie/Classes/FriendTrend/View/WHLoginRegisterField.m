//
//  WHLoginRegisterField.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/6.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHLoginRegisterField.h"
#import "UITextField+Placeholder.h"

@implementation WHLoginRegisterField

/*
 1.文本框光标要变成白色
 2.文本框开始编辑的时候，占位文字颜色变成白色
 */

- (void)awakeFromNib{
    [super awakeFromNib];
    //设置光标的颜色为白色
    self.tintColor = [UIColor whiteColor];
    //监听文本框编辑 : 1.代理 2.通知 3.target
    //原则：不要自己成为自己的代理(self.delegate = self;)
    //开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    //结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    /*快速设置占位文字颜色 =>文本框占位文字可能是label => 验证占位文字是label => 拿到label => 查看label属性名（1.runtime 2.断点）*/
//    self.pacceholdercolor = [UIColor redColor];
    //获取占位子的控件
//    UILabel *placeholderlabel = [self valueForKey:@"placeholderLabel"];
//    placeholderlabel.textColor = [UIColor redColor];
    self.placeholderColor = [UIColor grayColor];
}
#pragma mark - 文本框开始编辑
- (void)textBegin{
    //设置占位文字颜色变成白色
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
//    UILabel *placeholderlabel = [self valueForKey:@"placeholderLabel"];
//    placeholderlabel.textColor = [UIColor whiteColor];
    self.placeholderColor = [UIColor whiteColor];
}
#pragma mark - 文本框结束编辑
- (void)textEnd{
    //恢复文本原来的颜色
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
//    UILabel *placeholderlabel = [self valueForKey:@"placeholderLabel"];
//    placeholderlabel.textColor = [UIColor redColor];
    self.placeholderColor = [UIColor grayColor];
}

@end
