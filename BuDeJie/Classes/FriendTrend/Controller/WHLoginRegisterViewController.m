//
//  WHLoginRegisterViewController.m
//  BuDeJie
//
//  Created by 王辉 on 2017/8/6.
//  Copyright © 2017年 ronaldo. All rights reserved.
//

#import "WHLoginRegisterViewController.h"
#import "WHLoginRegisterView.h"
#import "WHFastLoginView.h"

@interface WHLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation WHLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //创建登录界面添加到中间view上
    WHLoginRegisterView *loginView = [WHLoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    //添加注册界面到中间view上
    WHLoginRegisterView *registerView = [WHLoginRegisterView registerView];
    [self.middleView addSubview:registerView];
    //创建快速登录界面到底部view上
    WHFastLoginView *fastLoginView = [WHFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];

}
- (void)viewDidLayoutSubviews{
    //一定也要调用super
    [super viewDidLayoutSubviews];
    
    WHLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.wh_width * 0.5, self.middleView.wh_height);
    WHLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.wh_width * 0.5, 0, self.middleView.wh_width * 0.5, self.middleView.wh_height);
    WHFastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
    
}
#pragma mark - 返回上一控制器
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)clickRegister:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    //平移中间的view
    _leadCons.constant = _leadCons.constant == 0? -self.middleView.wh_width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
