//
//  WHPictureViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/9.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHPictureViewController.h"

@interface WHPictureViewController ()

@end

@implementation WHPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WHRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(WHNavMaxY + WHTitlesViewH, 0, WHTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:WHTabBarButtonRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:WHTitleButtonRepeatClickNotification object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 监听
/**
 监听tabBarButton重复点击
 */
- (void)tabBarButtonRepeatClick{
    //if(重复点击的不是精华按钮) return;
    if (self.view.window == nil) return;
    
    //if(显示在正中间的不是AllViewController) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    WHLog(@"%@ - 刷新数据",self.class);
}
/**
 监听titleButton重复点击
 */
- (void)titleButtonRepeatClick{
    
    [self tabBarButtonRepeatClick];
    
}
#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd",self.class,indexPath.row];
    return cell;
}
@end
