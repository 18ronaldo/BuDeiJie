//
//  WHLoginRegisterView.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/6.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHLoginRegisterView.h"

@interface WHLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;

@end

@implementation WHLoginRegisterView

+ (instancetype)loginView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
}
+ (instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    //让按钮背景图片不被拉伸
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height *0.5];
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
//    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateHighlighted];
}

@end
