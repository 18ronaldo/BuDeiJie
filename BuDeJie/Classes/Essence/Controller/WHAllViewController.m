//
//  WHAllViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/9.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHAllViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "WHTopic.h"
#import <SVProgressHUD.h>

#import "WHTopicCell.h"

@interface WHAllViewController ()

/** 当前最后一条帖子数据的描述信息，专门用来加载下一页数据 **/
@property(nonatomic,copy) NSString *maxtime;
/** 所有帖子数据 **/
@property(nonatomic,strong) NSMutableArray<WHTopic *> *topics;

/** 下拉刷新控件 **/
@property (nonatomic,weak) UIView *header;
/** 下拉刷新控件里面的文字 **/
@property (nonatomic,weak) UILabel *headerLabel;
/** 下拉刷新控件是否正在刷新 **/
@property (nonatomic,assign,getter=isHeaderRefreshing) BOOL headerRefreshing;
/** 上拉刷新控件 **/
@property (nonatomic,weak) UIView *footer;
/** 上拉刷新控件里面的文字 **/
@property (nonatomic,weak) UILabel *footerLabel;
/** 上拉刷新控件是否正在刷新 **/
@property (nonatomic,assign,getter=isFooterRefreshing) BOOL footerRefreshing;

@end

@implementation WHAllViewController

//cell重用标识
static  NSString * const WHTopicCellId = @"WHTopicCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataCount = 7;
        [self.tableView reloadData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dataCount = 0;
            [self.tableView reloadData];
        });
    });
    */
//    self.dataCount = 5;
    
    self.view.backgroundColor = WHGrayColor(206);
    
    self.tableView.contentInset = UIEdgeInsetsMake(WHNavMaxY + WHTitlesViewH, 0, WHTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.tableView.rowHeight = 200;
    
    //注册cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([WHTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:WHTopicCellId];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:WHTabBarButtonRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:WHTitleButtonRepeatClickNotification object:nil];
    
    [self setupRefresh];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupRefresh{
    
    //广告
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, 0, 30);
    label.text = @"广告";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = label;
    
    //header
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, -50, self.tableView.wh_width, 50);
    self.header = header;
    [self.tableView addSubview:header];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = header.bounds;
    headerLabel.backgroundColor = [UIColor redColor];
    headerLabel.text = @"下拉可以刷新";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor whiteColor];
    [header addSubview:headerLabel];
    self.headerLabel = headerLabel;
    //让header自动进入刷新
    [self headerBeginRefreshing];
    
    //footer
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.wh_width, 35);
    self.footer = footer;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = @"上拉可以加载更多";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.textColor = [UIColor whiteColor];
    [footer addSubview:footerLabel];
    self.footerLabel = footerLabel;
    
    self.tableView.tableFooterView = footer;
    
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
    
    //进入下拉刷新
    [self headerBeginRefreshing];
    
//    WHLog(@"%@ - 刷新数据",self.class);
}
/**
    监听titleButton重复点击
 */
- (void)titleButtonRepeatClick{
    
    [self tabBarButtonRepeatClick];
    
}


#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据数据量显示或者隐藏footer
    self.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    WHTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
     */
    WHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:WHTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}
#pragma mark - 代理方法
/**
    当用户松开scrollView时调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    //如果正在下拉刷新，直接返回
//    if (self.isHeaderRefreshing) return;
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.wh_height);
    if (self.tableView.contentOffset.y <= offsetY) {//header已经完全出现
        [self headerBeginRefreshing];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //处理Header
    [self dealHeader];
    //处理Footer
    [self dealFooter];
}
/**
    处理Header
 */
- (void)dealHeader{
    
    //如果正在下拉刷新，直接返回
    if (self.isHeaderRefreshing) return;
    //当scrollView的偏移量的y值 <= offsetY时，代表header已经完全出现
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.wh_height);
    if (self.tableView.contentOffset.y <= offsetY) {
        //header已经完全出现
        self.headerLabel.text = @"松开立即刷新";
        self.headerLabel.backgroundColor = [UIColor grayColor];
    }else{
        self.headerLabel.backgroundColor = [UIColor redColor];
        self.headerLabel.text = @"下拉可以刷新";
    }
}
/**
    处理Footer
 */
- (void)dealFooter{
    //还没有任何内容的时候不需要判断
    if (self.tableView.contentSize.height == 0) return;
//    //如果正在上拉刷新，直接返回
//    if (self.isFooterRefreshing) return;
    
    //当scrollView的偏移量y值 >= offsetY时，代表footer已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.wh_height;
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        //footer完全出现，并且是往上拖拽
        [self footerBeginRefreshing];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.topics[indexPath.row].cellHeight;
    
}
#pragma mark - 数据处理
/**
    发送请求给服务器，下拉刷新数据
 */
- (void)loadNewTopics{
    
    //1.创建请求会话者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    //3.发送请求
    [mgr GET:WHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典数组 -> 模型数据
        self.topics = [WHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self headerEndRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WHLog(@"请求失败 - %@",error);
        [SVProgressHUD showWithStatus:@"网络繁忙，请稍后再试！"];
        //结束刷新
        [self headerEndRefreshing];
    }];
    
}
/**
    发送请求给服务器，上拉加载更多数据
 */
- (void)loadMoreTopics{
    
    //1.创建请求会话者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    parameters[@"maxtime"] = self.maxtime;
    //3.发送请求
    [mgr GET:WHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典数组 -> 模型数据
        NSArray *moreTopic = [WHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //累加到旧数组的后面
        [self.topics addObjectsFromArray:moreTopic];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self footerEndRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WHLog(@"请求失败 - %@",error);
        [SVProgressHUD showWithStatus:@"网络繁忙，请稍后再试！"];
        //结束刷新
        [self footerEndRefreshing];
    }];
    
}

#pragma mark - header
- (void)headerBeginRefreshing{
    //如果正在下拉刷新，直接返回
    if (self.isHeaderRefreshing) return;
    //如果正在上拉刷新，直接返回
    if (self.isFooterRefreshing) return;
    
    //进入下拉刷新状态
    self.headerRefreshing = YES;
    self.headerLabel.text =@"正在加载更多数据...";
    self.headerLabel.backgroundColor = [UIColor blueColor];
    //增加内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.wh_height;
        self.tableView.contentInset = inset;
        //修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, - inset.top);
    }];
    //发送请求给服务器，下拉刷新数据
    [self loadNewTopics];
}
- (void)headerEndRefreshing{
    self.headerRefreshing = NO;
    //减小内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.wh_height;
        self.tableView.contentInset = inset;
    }];
}
#pragma mark - footer
- (void)footerBeginRefreshing{
    //如果正在上拉刷新，直接返回
    if (self.isFooterRefreshing) return;
    //如果正在下拉刷新，直接返回
    if (self.isHeaderRefreshing) return;
    
    //进入上拉刷新状态
    self.footerRefreshing = YES;
    self.footerLabel.text = @"正在加载更多数据...";
    self.footerLabel.backgroundColor = [UIColor blueColor];
    //发送请求给服务器 - 上拉加载更多数据
    [self loadMoreTopics];
}
- (void)footerEndRefreshing{
    self.footerRefreshing = NO;
    self.footerLabel.text = @"上拉可以加载更多";
    self.footerLabel.backgroundColor = [UIColor redColor];
}

@end
