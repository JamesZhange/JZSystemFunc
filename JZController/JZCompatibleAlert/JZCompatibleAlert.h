//
//  JZCompatibleAlert.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/6/17.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JZCAlertControllerStyle) {
    JZCAlertStyleActionSheet = 0,
    JZCAlertStyleAlert
};

typedef void (^ButtonAction)(void);
typedef void (^AlertCompletion)(void);







@interface JZCompatibleAlert : NSObject

// alertController title
@property (nonatomic, strong) UILabel *titleLabel;
// alertController message
@property (nonatomic, strong) UILabel *messageLabel;



-(instancetype)initWithWithTitle: (NSString*)title
                         message: (NSString*)message
                           style: (JZCAlertControllerStyle)style;
-(UITextField*)addTextFieldWithTag: (NSInteger)tag;
-(UITextField*)textfieldWithTag: (NSInteger)tag;

-(int)addCancelButtonTitle: (NSString*)title
                     action: (ButtonAction)action;

-(int)addDestructiveButtonTitle: (NSString*)title
                         action: (ButtonAction)action;

-(int)addDefaultButtonTitle: (NSString*)title
                     withTag: (NSInteger)tag
                      action: (ButtonAction)action;

-(void)defaultButtonTag: (NSInteger)tag
                 enable: (BOOL)enable;

-(void)showOnViewController: (UIViewController*)viewcontroller
                   animated: (BOOL)animated
                 completion: (AlertCompletion)completion;

-(void)closeAlertViewAnimated: (BOOL)animated
                   completion: (AlertCompletion)completion;

// 定制
/*
   NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"提示内容"];
 
 * [attrStr addAttribute: NSFontAttributeName
                   value:[UIFont fontWithName:@"NotoSansCJKsc-Bold" size:14]
                   range: NSMakeRange(0, message.length)];
 
   [attrStr addAttribute: NSForegroundColorAttributeName 
                   value: [Tools colorWithHexString:@"#0b0b0b"] 
                   range: NSMakeRange(0, message.length)];
 */
-(void)setAttributedStringForAlertTitle:(id)attrStr;
-(void)setAttributedStringForAlertMessage:(id)attrStr;

@end
