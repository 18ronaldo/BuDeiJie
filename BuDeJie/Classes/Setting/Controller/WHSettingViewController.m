//
//  WHSettingViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/30.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHSettingViewController.h"
#import <SDImageCache.h>

static NSString * const ID = @"cell";
@interface WHSettingViewController ()

@end

@implementation WHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条左边（返回）按钮
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBtnWithnormalImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    self.title = @"设置";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}
//- (void)back{
//    //返回上一控制器
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //计算缓存数据，计算整个应用的程序的缓存数据 => (沙盒cache) => 获取cache文件夹尺寸
    //SDWebImage:帮我们做了缓存
    cell.textLabel.text = @"清除缓存";
    
    return cell;
}
#pragma mark - 自己去计算SDWebImage做的缓存
- (void)getFileSize{
    //NSFileManager
    
}


 

@end
