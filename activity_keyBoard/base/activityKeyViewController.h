//
//  activityKeyViewController.h
//  webtest
//
//  Created by jhaoheng on 2016/3/21.
//  Copyright © 2016年 max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "keyboardVC.h"

@protocol finishDelegate

-(void)AKV_finish:(NSString *)value;

@end

@interface activityKeyViewController : UIViewController<kbDelegate>
{
    UIToolbar *toolBar;
    UILabel *hor_title;
    
    NSString *activity_serial;//最後送給 lib 的字串
    
    UIView *pin_view;
    CGFloat as_img_size, as_img_padding;
    
    UIImageView *selectedImg_1, *selectedImg_2, *selectedImg_3, *selectedImg_4;
    UIImageView *selectedImg_5, *selectedImg_6, *selectedImg_7, *selectedImg_8;
    
    //pinArray
    NSMutableArray *pinArray;
    
    
    //
    NSObject<finishDelegate> *_delegate;
}

@property (nonatomic, strong) NSString *mainText;
@property (nonatomic, strong) NSString *secondText;
@property (nonatomic, strong) NSString *passWord;// 8 numbers code
@property (nonatomic) int errorTimes;

@property (nonatomic, retain) NSObject<finishDelegate> *_delegate;

@end
