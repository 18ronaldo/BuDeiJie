//
//  WHFriendTrendViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/28.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHFriendTrendViewController.h"
#import "WHLoginRegisterViewController.h"
#import "UITextField+Placeholder.h"

@interface WHFriendTrendViewController ()


@end

@implementation WHFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
}

#pragma mark - 设置导航条
- (void)setupNavBar{
    
    //1.左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithnormalImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    //2.title
    self.navigationItem.title = @"我的关注";
    
}
//推荐关注
- (void)friendsRecomment{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 点击登录注册就会调用
- (IBAction)clickLoginRegister:(id)sender {
    //进入到登录注册界面
    WHLoginRegisterViewController *loginVC = [[WHLoginRegisterViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}




@end
