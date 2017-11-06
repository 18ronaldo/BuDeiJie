//
//  WHNavigationController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/29.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHNavigationController.h"

@interface WHNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.interactivePopGestureRecognizer.delegate = self;
    //全屏滑动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    //控制手势什么时候触发，只有非根控制器才需要触发手势
    pan.delegate = self;
    //禁止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    //假死状态：程序还在运行，但是界面死了
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)load{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    //只要通过模型设置，都是通过富文本设置
    //设置导航条标题 => UINavigationBar
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:dict];
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //设置返回按钮，只有非根控制器
    if (self.childViewControllers.count > 0) {//非根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBtnWithnormalImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
        
    }
    
    //真正的跳转
    [super pushViewController:viewController animated:YES];
    
}
- (void)back{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}

@end
