//
//  JZBaseViewController.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/2/5.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMultiDelegateObject.h"





@interface JZBaseViewController : UIViewController

@property (strong, nonatomic) NSArray<JZMultiDelegateObject*> *notifierArray;
@property (nonatomic) NSInteger tag;


#if false // 用 TPKeyboardAvoiding 代替关闭键盘的效果比较好
#pragma mark - 键盘事件，有 textfield 时
-(void)registKeyboardNotificationForTextfileds: (NSArray*)textfields;
// notification
-(void)keyboardWillShow:(NSNotification *)noti;
-(void)keyboardWillHide:(NSNotification *)noti;
// 触摸背景来关闭虚拟键盘
-(IBAction)touchBackgroundDownEvent:(UIControl *)sender;
-(IBAction)textFiledIsReturn:(UITextField*)sender;
#endif




@end


