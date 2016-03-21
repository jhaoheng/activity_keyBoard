//
//  keyboardVC.h
//  webtest
//
//  Created by jhaoheng on 2016/3/21.
//  Copyright © 2016年 max. All rights reserved.
//

/*
 1. 每個按鈕(w,h) = ( 頁面寬度 - 2*(左右間隔) - 5*(每個按鈕上下左右間隔) )/4
 2. 若 (兩邊間隔) = 10 ; (每個按鈕上下左右間隔) = 15 ; 則 min(長,寬) = 56.25
 3. 56.25*4 + 5*15 + 10*2 = 320 最小寬度
 動態鍵盤 keyboardView(w,h)
 - w = (螢幕寬度) - 2*(左右間隔)
 - h = (每個按鈕 h)*3 + 4*(每個按鈕上下左右間隔)
 
 排列:
 btn1 ; btn2 ; btn3 ; btn4
 btn5 ; btn6 ; btn7 ; btn8
 btn9 ; btn10; btn11; btn12
 */

#import <UIKit/UIKit.h>

@protocol kbDelegate

-(void)kb_click:(NSString *)btn_string;

@end

@interface keyboardVC : UIViewController
{
    UIView *keyboardView;
    NSMutableArray *imgArray;
    NSMutableArray *randomArray;
    
    NSObject<kbDelegate> *_delegate;
}

@property (nonatomic, retain) NSObject<kbDelegate> *_delegate;

@property (nonatomic) CGFloat side_interval, btn_interval, btn_size;
@property (nonatomic) CGSize kb_size;

@end
