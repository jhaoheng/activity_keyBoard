//
//  ViewController.m
//  activity_keyBoard
//
//  Created by jhaoheng on 2016/3/21.
//  Copyright © 2016年 max. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pw_str = @"11111111";
    
    CGFloat btn_w = CGRectGetWidth(self.view.frame);
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *set_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    set_btn.frame = CGRectMake(0, 100, btn_w, 100);
    set_btn.backgroundColor = [UIColor redColor];
    [set_btn setTitle:[NSString stringWithFormat:@"設定密碼"] forState:UIControlStateNormal];
    [set_btn addTarget:self action:@selector(set_activity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:set_btn];
    
    
    UIButton *verify_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    verify_btn.frame = CGRectMake(0, CGRectGetMaxY(set_btn.frame), btn_w, 100);
    verify_btn.backgroundColor = [UIColor blueColor];
    [verify_btn setTitle:[NSString stringWithFormat:@"驗證密碼:%@",pw_str] forState:UIControlStateNormal];
    [verify_btn addTarget:self action:@selector(verify_activity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verify_btn];
    
    
    UIButton *reset_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    reset_btn.frame = CGRectMake(0, CGRectGetMaxY(verify_btn.frame), btn_w, 100);
    reset_btn.backgroundColor = [UIColor greenColor];
    [reset_btn setTitle:[NSString stringWithFormat:@"重設密碼:%@",pw_str] forState:UIControlStateNormal];
    [reset_btn addTarget:self action:@selector(reset_activity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reset_btn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)set_activity
{
    activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
    temp.mainText = @"主要標題";
    temp.secondText = @"次要標題";
    temp.AKBType = AKeyBoardType_settingPin;
    temp._delegate = self;
    [self presentViewController:temp animated:YES completion:nil];
}

- (void)verify_activity
{
    activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
    temp.mainText = @"主要標題";
    temp.secondText = @"次要標題";
    temp.AKBType = AKeyBoardType_verifyPin;
    temp.passWord = pw_str;
    temp.errorTimes_limited = 3;
    temp._delegate = self;
    [self presentViewController:temp animated:YES completion:nil];
}

- (void)reset_activity
{
    activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
    temp.mainText = @"主要標題";
    temp.secondText = @"次要標題";
    temp.AKBType = AKeyBoardType_resetPin;
    temp.passWord = pw_str;
    temp.errorTimes_limited = 3;
    temp._delegate = self;
    [self presentViewController:temp animated:YES completion:nil];
}

#pragma activity Key Board delegate
- (void)AKV_finish:(NSString *)value
{
    NSLog(@"finish serial(PW) is : %@",value);
}

@end
