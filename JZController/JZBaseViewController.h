//
//  FADBaseViewController.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/2/5.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMultiDelegateObject.h"

@protocol FADBaseViewSwitchDelegate <NSObject>
@optional
// -(void)OnMMDrawLeftBarbuttonClicked;

@end






@interface FADBaseViewController : UIViewController

@property (nonatomic, weak) id<FADBaseViewSwitchDelegate> mmdrawDelegate;

@property (weak, nonatomic) IBOutlet UILabel *PageTitleLabel;

@property (strong, nonatomic) NSArray<JZMultiDelegateObject*> *notifierArray;

@property (nonatomic) NSInteger tag;

#if false //
#pragma mark - 键盘事件，有 textfield 时
-(void)registKeyboardNotificationForTextfileds: (NSArray*)textfields;
// notification
-(void)keyboardWillShow:(NSNotification *)noti;
-(void)keyboardWillHide:(NSNotification *)noti;
// 触摸背景来关闭虚拟键盘
-(IBAction)touchBackgroundDownEvent:(UIControl *)sender;
-(IBAction)textFiledIsReturn:(UITextField*)sender;
#endif


/*
 现在的通知方式是AppViewManger用Multidelegate 方式广播来通知信息的。
 BaseViewController 留了这个接口，但是没有使用。
 仍然留着这个接口，因为 AppViewManger 如果统一管理所有页面，则其可以知道哪些界面需要被通知，
 这时就可以通过 BaseViewController 的接口直接调用这个函数了。
 [2015-06-24 James]
 */
// 留作子类来重载的接口
#pragma mark - AppViewsManagerNotification
-(void)AppDidEnterBackground;
-(void)AppWillEnterForeground;


// 可重载的工具函数
-(IBAction)goBackToThisView:(UIStoryboardSegue *)segue;
-(IBAction)OnGobackButtonClicked:(id)sender;
-(void)setButtonHLBG: (UIButton*)button
             HLColor: (UIColor*)color;

@end


