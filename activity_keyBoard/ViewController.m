//
//  ViewController.m
//  activity_keyBoard
//
//  Created by jhaoheng on 2016/3/21.
//  Copyright © 2016年 max. All rights reserved.
//

#import "ViewController.h"
#import "activityKeyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"Start" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(activity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)activity
{
    activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
    temp.mainText = @"請設定交易密碼";
    temp.secondText = @"密碼設定完成，才完成註冊程序";
    temp.passWord = @"12345678";
    temp.errorTimes = 3;
    [self presentViewController:temp animated:YES completion:nil];
}

@end
