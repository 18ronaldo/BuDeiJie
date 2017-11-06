//
//  WHNewViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/28.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHNewViewController.h"
#import "WHSubscibeTagViewController.h"

@interface WHNewViewController ()

@end

@implementation WHNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    [self setupNavBar];
}

#pragma mark - 设置导航条
- (void)setupNavBar{
    
    //1.左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithnormalImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    //2.titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}
#pragma mark - 点击订阅（subscibe）标签
- (void)tagClick{
    
    //进入推荐订阅标签界面
    WHSubscibeTagViewController *subTag = [[WHSubscibeTagViewController alloc] init];
    [self.navigationController pushViewController:subTag animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
