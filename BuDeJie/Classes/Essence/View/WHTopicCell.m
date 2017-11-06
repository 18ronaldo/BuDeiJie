//
//  WHTopicCell.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/15.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHTopicCell.h"
#import "WHTopic.h"
#import <UIImageView+WebCache.h>

@interface WHTopicCell ()

// 控件的命名 -> 功能 + 控件类型

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation WHTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (void)setTopic:(WHTopic *)topic{
    _topic = topic;
    
    //顶部控件的数据
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] wh_circleImage];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholderImage options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //图片下载失败直接返回，按照它的默认做法
        if (!image) {
            return ;
        }
        
        self.profileImageView.image = [image wh_circleImage];;
    }];
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_Label.text = topic.text;
    
    //底部按钮的文字
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
}

- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder: (NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }
    else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 2;
//    frame.size.width -= 4;
    frame.size.height -= WHMargin;
    [super setFrame:frame];
}

@end
