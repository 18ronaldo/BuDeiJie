//
//  WHMeViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/7/28.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHMeViewController.h"
#import "WHSettingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "WHSquareItem.h"
#import <MJExtension/MJExtension.h>
#import "WHSquareCell.h"
#import <WebKit/WebKit.h>


static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (WHScreenW - (cols - 1) * margin) / cols

@interface WHMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) NSMutableArray *squareItems;
@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation WHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setupNavBar];
    //设置tableView底部视图
    [self setupFootView];
    //展示方块内容 -> 请求数据(查看接口文档)
    [self loadData];
    /*
        跳转细节：
        1.collectionView高度重新计算 => collectionView高度需要根据内容去计算 => 有数据了需要再计算下高度
        2.collectionView不需要滚动
     */
    //处理cell间距，默认tabelView分组样式，有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = WHMargin;
    
    self.tableView.contentInset = UIEdgeInsetsMake(WHMargin - 35, 0, 0, 0);
    
}
#pragma mark - 设置导航条
- (void)setupNavBar{
    
    //title
    self.navigationItem.title = @"我的";
//    //设置导航条标题 => UINavigationBAr
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
//    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    //右边的夜间模式按钮和设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithnormalImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithnormalImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
}
#pragma mark - 夜间模式
- (void)night:(UIButton *)button{
    button.selected = !button.selected;
}

#pragma mark - 设置
- (void)setting{
    
    //跳转到设置界面
    WHSettingViewController *settingVC = [[WHSettingViewController alloc] init];
    //必须要在跳转之前设置
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
    
    /*
        1.底部条没有隐藏
        2.处理返回按钮 ： 去设置控制器里
     */

}
#pragma mark - 设置tableView底部视图
- (void)setupFootView{
    /*
        1.初始化要设置流水布局
        2.cell必须要注册
        3.cell必须自定义
     */
    
    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置cell尺寸
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    //创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"WHSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //从缓存池中取
    WHSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareItems[indexPath.row];
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //跳转界面 push 展示网页
    /*
        1.Safari openURL : 自带很多功能（进度条，刷新，前进，倒退，等等功能），必须跳出当前应用
        2.UIWebView （没有功能）在当前应用打开网页，并没有safari，自己实现，UIWebView不能实现进度条
        3.SFSafariViewController:专门用来展示网页 需求：既想要在我当前应用展示网页，有想要safari功能 ios9才能使用
            a.导入#import <SafariServices/SafariServices.h>
            b.
        4.WKWebView: IOS8 UIWebView升级版本，添加基本功能 a.监听进度条 b.缓存 
            4.1.导入#import <WebKit/WebKit.h>
            4.2.
     */
    
}
#pragma mark - 请求数据
- (void)loadData{
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    //3.发送请求
    [mgr GET:WHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSArray *dictArr = responseObject[@"square_list"];
        //字典数组转模型数组
        _squareItems = [WHSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        //处理数据
        [self resloveData];
        
        //设置下collectionView 计算collectionView高度 = rows * itemWH
        //万能公式：Rows = (count - 1) / cols + 1
        NSInteger counts = _squareItems.count;
        NSInteger rows = (counts - 1) / cols + 1;
        //设置collectionView高度
        self.collectionView.wh_height = rows * itemWH;
        //设置tabelView滚动范围
        self.tableView.tableFooterView = self.collectionView;
        //刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 处理请求完成的数据
- (void)resloveData{
    //判断下缺几个
    // 3 % 4 = 3  cols - 3 = 1
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            WHSquareItem *item = [[WHSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
