//
//  WHTabBarController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/28.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHTabBarController.h"
#import "WHMeViewController.h"
#import "WHNewViewController.h"
#import "WHEssenceViewController.h"
#import "WHPublishViewController.h"
#import "WHFriendTrendViewController.h"
#import "UIImage+Image.h"
#import "WHTabBar.h"
#import "WHNavigationController.h"

@interface WHTabBarController ()

@end

@implementation WHTabBarController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加子控制器
    [self setupAllChildViewController];
    //2.设置tabBar上按钮内容  -->  由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    //3.自定义tabBar
    [self setuptabBar];
    
}

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController{

    //精华
    WHEssenceViewController *essenceVC = [[WHEssenceViewController alloc] init];
    WHNavigationController *navEssence = [[WHNavigationController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:navEssence];
    //新帖
    WHNewViewController *newVC = [[WHNewViewController alloc] init];
    WHNavigationController *navNew = [[WHNavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:navNew];
//    //发布
//    WHPublishViewController *publishVC = [[WHPublishViewController alloc] init];
//    //UINavigationController *navPublish = [[UINavigationController alloc] initWithRootViewController:publishVC];
//    [self addChildViewController:publishVC];
    //关注
    WHFriendTrendViewController *friendtrendVC = [[WHFriendTrendViewController alloc] init];
    WHNavigationController *navFriendtrend = [[WHNavigationController alloc] initWithRootViewController:friendtrendVC];
    [self addChildViewController:navFriendtrend];
    //我 是通过storyboard创建
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([WHMeViewController class]) bundle:nil];
    WHMeViewController *meVC = [storyboard instantiateInitialViewController];//加载箭头指向控制器
    WHNavigationController *navMe = [[WHNavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:navMe];
    
}

#pragma mark - 设置tabBar上按钮内容
- (void)setupAllTitleButton{
    
    //1.精华
    UINavigationController *navEssence = self.childViewControllers[0];
    navEssence.tabBarItem.title = @"精华";
    navEssence.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //快速生成一个没有被渲染的图片
    navEssence.tabBarItem.selectedImage = [UIImage imageWithOriginalWithName:@"tabBar_essence_click_icon"];
    //2.新帖
    UINavigationController *navNew = self.childViewControllers[1];
    navNew.tabBarItem.title = @"新帖";
    navNew.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    navNew.tabBarItem.selectedImage = [UIImage imageWithOriginalWithName:@"tabBar_new_click_icon"];
//    //3.发布
//    WHPublishViewController *publishVC = self.childViewControllers[2];
//    //publishVC.tabBarItem.title = @"发布";
//    publishVC.tabBarItem.image = [UIImage imageWithOriginalWithName:@"tabBar_publish_icon"];
//    publishVC.tabBarItem.selectedImage = [UIImage imageWithOriginalWithName:@"tabBar_publish_click_icon"];
//    //设置图片的位置
//    publishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //4.关注
    UINavigationController *navFriendtrend = self.childViewControllers[2];
    navFriendtrend.tabBarItem.title = @"关注";
    navFriendtrend.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    navFriendtrend.tabBarItem.selectedImage = [UIImage imageWithOriginalWithName:@"tabBar_friendTrends_click_icon"];
    //5.我
    UINavigationController *navMe = self.childViewControllers[3];
    navMe.tabBarItem.title = @"我";
    navMe.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    navMe.tabBarItem.selectedImage = [UIImage imageWithOriginalWithName:@"tabBar_me_click_icon"];
    
}

#pragma mark - 自定义tabBar
- (void)setuptabBar{
    
    WHTabBar *tabBar = [[WHTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

//只会调用一次
/**
    appearance: 只能在控件显示之前设置才能作用
    1.只要遵守了UIAppearance协议，还要实现这个方法
    2.那些属性可以通过appearance设置，只有被UI_APPEARANCE_SELECTOR宏修饰的属性才能设置
    使用场景：夜间模式
 */
+ (void)load{
    //获取整个应用程序下的UITabBarItem
//    UITabBarItem *item = [UITabBarItem appearance];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //设置按钮选中标题的颜色:富文本：描述一个文字颜色，字体阴影空心，图文混排
    //创建一个描述文本属性的字典
    NSMutableDictionary *dicts = [NSMutableDictionary dictionary];
    dicts[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:dicts forState:UIControlStateSelected];
    //设置字体的尺寸：只有正常状态下，才会有效
    NSMutableDictionary *dictsNor = [NSMutableDictionary dictionary];
    dictsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dictsNor forState:UIControlStateNormal];
    
}
//注意：可能会调用多次
//+ (void)initialize{
//    if (self == [WHTabBarController class]) {
//        
//    }
//}

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
