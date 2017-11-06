//
//  WHSubscibeTagViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/1.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHSubscibeTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "WHSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "WHSubTagCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString * const ID = @"cell";
@interface WHSubscibeTagViewController ()

@property(nonatomic,strong) NSArray *subTags;

@property (nonatomic,weak) AFHTTPSessionManager *mgr;

@end

@implementation WHSubscibeTagViewController
//接口文档： 请求url （基本url+请求的参数） 请求方式
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //展示标签数据 -> 请求数据（接口文档）-> 解析数据（写成plist文件）（image_list,sub_number,theme_name）-> 设计模型 -> 字典转模型 -> 展示数据
    [self loadDate];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"WHSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    self.title = @"推荐订阅";
    //处理cell分割线 1.自定义分割线 2.系统属性（ios8才支持） 3.万能方式（重写cell的setFrame） 了解tableView底层实现 a.取消系统自带分割线 b.把tableView的背景色设置为分割线的颜色 c.重写setFrame
    //清空tableView分割线内边距，清空cell的约束边缘
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WHColor(200, 199, 204);
    //提示用户当前正在加载数据 SVPro
    [SVProgressHUD showWithStatus:@"正在加载ing..."];
}
#pragma mark - 请求数据
- (void)loadDate{
    /*http://api.budejie.com/api/api_open.php*/
    //1.创建请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    _mgr = mgr;
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    //3.发送请求
    [mgr GET:WHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            //字典数组转换模型数组
            _subTags = [WHSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
            //刷新表格
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
        }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //自定义cell
    WHSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //注意点：如果我们的cell从cell加载，一定要记得绑定标识符
    //注册cell
//    if (cell ==nil) {
//        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WHSubTagCell class]) owner:nil options:nil][0];
//    }
    //获取模型
    WHSubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;

    
    return cell;
}
//适应自定义cell设置的高度80
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//界面即将消失的时候调用
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //销毁指示器
    [SVProgressHUD dismiss];
    //取消之前的请求
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}



@end
