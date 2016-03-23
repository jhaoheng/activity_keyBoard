//
//  activityKeyViewController.h
//  webtest
//
//  Created by jhaoheng on 2016/3/21.
//  Copyright © 2016年 max. All rights reserved.
//


#import <UIKit/UIKit.h>
#include "imgCodeDefine.h"
#import "keyboardVC.h"

typedef NS_ENUM(int, AKeyBoardType) {
    AKeyBoardType_settingPin,
    AKeyBoardType_verifyPin,
    AKeyBoardType_resetPin
};

#define AKeyBoardType_String(enum) [@[@"AKeyBoardType_settingPin",@"AKeyBoardType_verifyPin",@"AKeyBoardType_resetPin"] objectAtIndex:enum]

typedef NS_ENUM(int, btnType){
    //AKeyBoardType_settingPin
    setting_first,
    setting_second,
    
    //AKeyBoardType_verifyPin
    verify_first,
    
    //AKeyBoardType_changePin
    reset_first,
    reset_second,
    reset_third
};

@protocol finishDelegate

-(void)AKV_finish:(NSString *)value;

@end

@interface activityKeyViewController : UIViewController<kbDelegate>
{
    UIToolbar *toolBar;
    UILabel *hor_title;
    
    NSString *tempPw_serial;
    NSString *activity_serial;//最後送給 lib 的字串
    
    UIView *pin_view;
    CGFloat as_img_size, as_img_padding;
    
    UIImageView *selectedImg_1, *selectedImg_2, *selectedImg_3, *selectedImg_4;
    UIImageView *selectedImg_5, *selectedImg_6, *selectedImg_7, *selectedImg_8;
    
    //pinArray
    NSMutableArray *pinArray;
    
    
    //
    NSObject<finishDelegate> *_delegate;
    
    //目前按鈕的狀態
    int btn_status;
    
    //目前驗證錯誤次數
    int verifyErrorTimes;
}

@property (nonatomic, retain) NSObject<finishDelegate> *_delegate;

@property (nonatomic, strong) NSString *mainText;
@property (nonatomic, strong) NSString *secondText;

@property (nonatomic) AKeyBoardType AKBType;

/*
 [AKeyBoardType_settingPin] : 設定 pin 模式
 輸入兩次 pin 碼
 (1) btn : 下一步/返回
 (2) btn : 確認/返回
 
 ex:
 activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
 temp.mainText = @"主要標題";
 temp.secondText = @"次要標題";
 temp.AKBType = AKeyBoardType_settingPin;
 temp._delegate = self;
 [self presentViewController:temp animated:YES completion:nil];
 */


/*
 [AKeyBoardType_verifyPin] : 驗證 pin 模式
 btn : 驗證/取消
 
 ex:
 activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
 temp.mainText = @"主要標題";
 temp.secondText = @"次要標題";
 temp.AKBType = AKeyBoardType_settingPin;
 temp.passWord = @"12345678";
 temp.errorTimes_limited = 3;
 temp._delegate = self;
 [self presentViewController:temp animated:YES completion:nil];
 
 */
@property (nonatomic, strong) NSString *passWord;//放入比對的 password，要八碼
@property (nonatomic) int errorTimes_limited;//錯誤上限次數

/*
 [AKeyBoardType_changePin] : 變更 pin 模式
 (1) btn : 驗證/取消
 (2) btn : 下一步/取消
 (3) btn : 完成/取消
 */

@end


