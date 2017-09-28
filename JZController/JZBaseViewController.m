//
//  JZBaseViewController.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/2/5.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import "JZBaseViewController.h"
#import "AppViewsCustomStyleDefine.h"






@interface JZBaseViewController ()
{

}
@end



@implementation JZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _notifierArray = nil;
    // self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.view layoutIfNeeded];
    
    // 添加自身成代理
    for (JZMultiDelegateObject* notifier in _notifierArray) {
        [notifier addDelegateInMainQueue: self];
    }

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
    for (JZMultiDelegateObject* notifier in _notifierArray) {
        [notifier removeDelegate: self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}


// iOS9 以后用复写这个函数来控制状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault; // 黑色
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 页面旋转相关
- (BOOL)shouldAutorotate {
    return NO;
}

//当前viewcontroller支持那些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

//当前viewcontroller默认的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}




@end
