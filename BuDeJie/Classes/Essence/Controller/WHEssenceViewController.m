//
//  WHEssenceViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/28.
//  Copyright © 2017年 ronaldo. All rights reserved.
//
/*
    名字叫attributes并且是NSDictionary *类型的参数，它的key一般都有一下规律
    1.ios7开始
    2.所有的key都来源于：NSAttributedString.h
    3.格式基本都是：NS***AttributeName
 
    1.ios7之前
    2.所有的key都来源于：UIStringDrawing.h
    3.格式基本都是：UITextAttribute***

 */

#import "WHEssenceViewController.h"
#import "WHTitleButton.h"

#import "WHAllViewController.h"
#import "WHVideoViewController.h"
#import "WHVoiceViewController.h"
#import "WHPictureViewController.h"
#import "WHWordViewController.h"

@interface WHEssenceViewController ()<UIScrollViewDelegate>
/** 标题栏 **/
@property (nonatomic,weak) UIView *titlesView;
/** 标题下划线 **/
@property (nonatomic,weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 **/
@property (nonatomic,weak) WHTitleButton *previousClickedTitleButton;
/** 用来存放所有子控制器view的scrollView **/
@property (nonatomic,weak) UIScrollView *scrollView;

@end

@implementation WHEssenceViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    //初始化子控制
    [self setupChidVCs];
    
    //设置导航条
    [self setupNavBar];
    
    //scrollView
    [self setupScrollView];
    //标题栏
    [self setupTitlesView];
    //标题下划线
    [self setupUnderline];
    //添加第0个子控制器的View
    [self addChidVCViewIntoScrollView:0];
    
}
/**
    初始化子控制器
 */
- (void)setupChidVCs{
    [self addChildViewController:[[WHAllViewController alloc] init]];
    [self addChildViewController:[[WHVideoViewController alloc] init]];
    [self addChildViewController:[[WHVoiceViewController alloc] init]];
    [self addChildViewController:[[WHPictureViewController alloc] init]];
    [self addChildViewController:[[WHWordViewController alloc] init]];
}
/**
    设置导航条
 */
- (void)setupNavBar{
    
    /*
        UIBarButtonLtem:描述按钮具体内容
        UINavigationItem:设置导航条上内容（左边，中间，右边）
        tabBarItem:设置tabBar上按钮内容（tabBarButton）
     */
    
    //1.左边游戏（game）按钮
//    UIButton *gameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [gameBtn setImage:[UIImage imageNamed:@"nav_item_game_icon"] forState:UIControlStateNormal];
//    [gameBtn setImage:[UIImage imageNamed:@"nav_item_game_click_icon"] forState:UIControlStateHighlighted];
//    [gameBtn sizeToFit];//自适应
//    [gameBtn addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
//    UIView *leftcontainView = [[UIView alloc] initWithFrame:gameBtn.bounds];
//    [leftcontainView addSubview:gameBtn];
    //吧UIButton包装成UIBarButtonItem，就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithnormalImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    //2.titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //3.右边随机（random）按钮
//    UIButton *randomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [randomBtn setImage:[UIImage imageNamed:@"navigationButtonRandom"] forState:UIControlStateNormal];
//    [randomBtn setImage:[UIImage imageNamed:@"navigationButtonRandomClick"] forState:UIControlStateHighlighted];
//    [randomBtn sizeToFit];
//    [randomBtn addTarget:self action:@selector(random) forControlEvents:UIControlEventTouchUpInside];
//    UIView *rightcontainView = [[UIView alloc] initWithFrame:randomBtn.bounds];
//    [rightcontainView addSubview:randomBtn];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithnormalImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];

}
/**
    设置scrollView
 */
- (void)setupScrollView{
    
    //不允许自动修改UIscrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.frame = self.view.bounds;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;//点击状态栏的时候，这个scrollView不会滚动到最顶部
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.wh_width;
//    CGFloat scrollViewH = scrollView.wh_height;
//    for (NSUInteger i = 0;i < count; i++) {
//        UIView *childVCView = self.childViewControllers[i].view;
//        childVCView.frame = CGRectMake(i * scrollView.wh_width, 0, scrollViewW, scrollViewH);
//        
//        [scrollView addSubview:childVCView];
//    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    
}
/**
    设置标题栏
 */
- (void)setupTitlesView{
    UIView *titlesView = [[UIView alloc] init];
    //设置半透明背景色
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
//    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
//    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //设置alpha会导致里面的所有子控件也有透明度(子控件会继承父控件设置的alpha透明度)
//    titlesView.alpha = 0.5;
    titlesView.frame = CGRectMake(0, WHNavMaxY, self.view.wh_width, WHTitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    [self setupTitleBouttons];
    
}

/**
    设置标题按钮
    (监听方法要设置在frame之前)
 */
- (void)setupTitleBouttons{
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = self.titlesView.wh_width * 0.2;
    CGFloat titleButtonH = self.titlesView.wh_height;
    for (NSUInteger i = 0 ; i < count; i++) {
        
        WHTitleButton *titleButton = [WHTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        //添加监听方法
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        //文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        //背景色
//        [titleButton setBackgroundColor:WHRandomColor];
        
        [self.titlesView addSubview:titleButton];
        
    }
    
}
/**
 标题下划线
 */
- (void)setupUnderline{
    //标题按钮
    WHTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    //下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.wh_height = 1;
    titleUnderline.wh_y = self.titlesView.wh_height - titleUnderline.wh_height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    //默认点击最前面的按钮
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    [firstTitleButton.titleLabel sizeToFit];//让label根据文字内容计算尺寸
    self.titleUnderline.wh_width = firstTitleButton.titleLabel.wh_width + WHMargin;
    self.titleUnderline.wh_centerX = firstTitleButton.wh_centerX;
}


#pragma mark - 监听
/**
    点击标题按钮
 */
- (void)titleButtonClick:(WHTitleButton *)titleButton{
    
    //重复点击标题按钮
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WHTitleButtonRepeatClickNotification object:nil];
//        WHFunc;
    }
    
    //切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    NSUInteger index = [self.titlesView.subviews indexOfObject:titleButton];
    [UIView animateWithDuration:0.2 animations:^{
        //处理下划线
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        attributes[NSFontAttributeName] = titleButton.titleLabel.font;
//        self.titleUnderline.wh_width = [titleButton.currentTitle sizeWithAttributes:attributes].width;
        self.titleUnderline.wh_width = titleButton.titleLabel.wh_width + WHMargin;
//        WHLog(@"%f",titleButton.titleLabel.wh_width);
        self.titleUnderline.wh_centerX = titleButton.wh_centerX;
        //滚动scrollView到【标题按钮】对应的控制器
        CGFloat offsetX = self.scrollView.wh_width * index;
//        CGFloat offsetX = self.scrollView.wh_width * titleButton.tag;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChidVCViewIntoScrollView:index];
    }];
    //设置index位置对应的tableView.scrollToTop = YES，其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVC = self.childViewControllers[i];
        //如果view还没有被创建，就不用去处理
        if (!childVC.isViewLoaded) continue;
        UIScrollView *scrollView = (UIScrollView *)childVC.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        scrollView.scrollsToTop = (i == index);

    }
    
}
/**
    游戏
 */
- (void)game{
    WHFunc;
}

/**
    随机
 */
- (void)random{
    WHFunc;
}

#pragma mark - UIScrollViewDelegate

/**
 当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.wh_width;
    //点击对应的标题按钮
    WHTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}

/**
 当用户送来scrollView时调用这个代理方法（结束拖拽的时候）
 */
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//}
#pragma mark - 其他方法

/**
 添加子控制器的view到scrollView中
 */
- (void)addChidVCViewIntoScrollView: (NSUInteger)index{
    UIView *childVCView = self.childViewControllers[index].view;
    if (childVCView.window) return;
    CGFloat scrollViewW = self.scrollView.wh_width;
    childVCView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.wh_height);
    [self.scrollView addSubview:childVCView];
}


@end
