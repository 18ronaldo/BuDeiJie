//
//  WHSquareCell.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/7.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHSquareCell.h"
#import <UIImageView+WebCache.h>
#import "WHSquareItem.h"

@interface WHSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation WHSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(WHSquareItem *)item{
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
}

@end
