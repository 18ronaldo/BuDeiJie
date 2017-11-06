//
//  WHTopic.h
//  BuDeJie
//
//  Created by 王辉 on 2017/8/15.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,WHTopicType)
{
    //全部
    WHTopicTypeAll = 1,
    //图片
    WHTopicTypePicture = 10,
    //文字
    WHTopicTypeWord = 29,
    //声音
    WHTopicTypeVoice = 31,
    //视频
    WHTopicTypeVideo = 41
};

@interface WHTopic : NSObject

/** 用户的名字 **/
@property(nonatomic,copy) NSString *name;
/** 用户的头像 **/
@property(nonatomic,copy) NSString *profile_image;
/** 帖子的文字内容 **/
@property(nonatomic,copy) NSString *text;
/** 帖子审核通过的时间 **/
@property(nonatomic,copy) NSString *passtime;

/** 顶数量 **/
@property(nonatomic,assign) NSInteger ding;
/** 踩数量 **/
@property(nonatomic,assign) NSInteger cai;
/** 转发/分享数量 **/
@property(nonatomic,assign) NSInteger repost;
/** 评论数量 **/
@property(nonatomic,assign) NSInteger comment;

@property(nonatomic,assign) CGFloat cellHeight;

@end

