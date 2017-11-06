//
//  WHAdItem.h
//  BuDeJie
//
//  Created by 王辉 on 2017/7/31.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import <Foundation/Foundation.h>

//w_picurl,ori_curl:跳转到广告界面,w,h
@interface WHAdItem : NSObject

/** 广告地址 **/
@property(nonatomic,strong) NSString *w_picurl;
/** 点击广告跳转的界面 **/
@property(nonatomic,strong) NSString *ori_curl;

@property(nonatomic,assign) CGFloat w;
@property(nonatomic,assign) CGFloat h;

@end
