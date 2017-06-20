//
//  FADBaseViewController.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/2/5.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import "JZBaseViewController.h"
#import "AppViewsCustomStyleDefine.h"
#import "AppModule.h"





@interface FADBaseViewController ()
{
    NSArray* mTextfieldArray;
    CGRect mCfgViewRectWhenKeyBoard;
}
@end



@implementation FADBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mTextfieldArray = nil;
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
    
    //页面统一标题字体
    // UIFont* titlefont = [UIFont fontWithName:GlobalViewNavbarTitleFontName size: GlobalViewNavbarTitleFontSize];
    // self.PageTitleLabel.font = titlefont;
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


// story board 返回

- (IBAction)goBackToThisView:(UIStoryboardSegue *)segue
{
    NSLog(@"go to %@", [[[segue sourceViewController] class] description]);
}

// 导航栏返回
- (IBAction)OnGobackButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

// 留作子类来重载的接口
#pragma mark - AppViewsManagerNotification
-(void)AppDidEnterBackground
{
    NSLog(@"Base view do nothing for AppDidEnterBackground");
}

-(void)AppWillEnterForeground
{
    NSLog(@"Base view do nothing for AppWillEnterForeground");
}




-(void)setButtonHLBG: (UIButton*)button
             HLColor: (UIColor*)color
{
    CGRect rect = button.bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [button setBackgroundImage:theImage forState:UIControlStateHighlighted];
}
























#if false //----------------- 用 TPKeyboardAvoiding 效果会比较好 ----------------------------------

#pragma mark - 解决虚拟键盘挡住UITextField的方法

-(void)registKeyboardNotificationForTextfileds: (NSArray*)textfields
{
    //--  registKeyboardNotification --
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    // 键盘高度变化通知，ios5.0新增的
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    
    //-- save textfields --
    mTextfieldArray = textfields;
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    CGRect frame = self.view.frame;
    
    if (frame.origin.y >= 0) {
        mCfgViewRectWhenKeyBoard = frame;
        frame.origin.y -= 80;
        [UIView beginAnimations:@"Curl" context:nil];//动画开始
        [UIView setAnimationDuration:0.30];
        [UIView setAnimationDelegate:self];
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    [UIView beginAnimations:@"Curl" context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:mCfgViewRectWhenKeyBoard];
    [UIView commitAnimations];
}



#pragma mark - 触摸背景来关闭虚拟键盘
- (IBAction)touchBackgroundDownEvent:(UIControl *)sender {
    
    if (nil != mTextfieldArray) {
        for (UITextField* textfield in mTextfieldArray) {
            if ([textfield isFirstResponder]) {
                [textfield resignFirstResponder];
            }
        }
    }
}

- (IBAction)textFiledIsReturn:(UITextField*)sender {
    if ([sender isFirstResponder]) {
        [sender resignFirstResponder];
    }
}


#endif //---------------------------------------------------



@end
