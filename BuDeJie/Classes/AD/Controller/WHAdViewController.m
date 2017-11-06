//
//  WHAdViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/30.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "WHAdItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "WHTabBarController.h"

//导入AFN框架：cocoapods（管理第三方库）
//cocoapods做的事情:导入一个框架，会把这个框架依赖的所有框架都导入
/*cocoapods步骤：
 1.创建podfile：描述需要导入那些框架  touch pdofile
 2.打开podfile去描述  open podfile
 3.搜索需要导入框架的描述 pod search AFN（例）
 4.安装第三方框架   pod install --no-repo-update
 5.只能用xxworkspace打开
 */
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface WHAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
/** 展示图片 **/
@property (nonatomic,weak) UIImageView *adView;
/** 广告模型 **/
@property(nonatomic,strong) WHAdItem *item;
/** 定时器 **/
@property (nonatomic,weak) NSTimer *timer;
//跳转按钮
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@end

@implementation WHAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置启动图片
    [self setupLaunchImage];
    //加载广告数据 => 拿到活数据 => 服务器 => 查看接口文档 1.判断借口对不对 2.解析数据(w_picurl,ori_curl:跳转到广告界面,w,h) => 请求数据（AFN）
    [self loadAdDate];
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}
#pragma mark - 点击跳过按钮做的事情
- (IBAction)clickJump:(id)sender {
    //销毁广告界面，进入主框架界面
    WHTabBarController *tabBarVC = [[WHTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    //干掉定时器
    [_timer invalidate];
}
- (void)timeChange{
    
    //倒计时
    static int i = 3;
    
    //设置跳转按钮文字
    if ( i == 0) {
        [self clickJump:nil];
    }
    i--;
    
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过 (%d)",i] forState:UIControlStateNormal];
    
}
#pragma mark - 懒加载
/*
    1.以后添加东西，首先想到加多少次
 */
- (UIImageView *)adView{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        
        [imageView addGestureRecognizer:tap];
        
        imageView.userInteractionEnabled = YES;
        
        [self.adContainView addSubview:imageView];
        
        _adView = imageView;
    }
    return _adView;
}
#pragma mark - 点击广告跳转
- (void)tap{
    
    //跳转到界面 -> safari
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    if ([app openURL:url]) {
        [app openURL:url];
    }
    
}

#pragma mark - 设置启动图片
- (void)setupLaunchImage{
    
    if (iphone6p) {//6p
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iphone6){//6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }else if (iphone5){//5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    }else if (iphone4){//4
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700@2x"];
    }

}
/*
    http://mobads.baidu.com/cpro/ui/mads.php?
 */
#pragma mark - 加载广告数据
- (void)loadAdDate{
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"code2"] = code2;
    //3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/wanghui/Desktop/不得姐/advertisement.plist" atomically:YES];
        //请求数据 -> 解析数据(写成plist文件) -> 设计模型 -> 展示数据
//        NSLog(@"%@",responseObject);
        //获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        //字典转模型
        _item = [WHAdItem mj_objectWithKeyValues:adDict];
        //创建UIImageView展示图片
        CGFloat h = WHScreenW / _item.w * _item.h;
        self.adView.frame = CGRectMake(0, 0, WHScreenW, h);
        //加载广告网页
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    //4.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
