//
//  activityKeyViewController.m
//  webtest
//
//  Created by jhaoheng on 2016/3/21.
//  Copyright © 2016年 max. All rights reserved.
//

#import "activityKeyViewController.h"

@interface activityKeyViewController ()

@end

@implementation activityKeyViewController
@synthesize mainText,secondText;
@synthesize passWord;
@synthesize errorTimes;

#pragma kb delegate
- (void)kb_click:(NSString *)btn_string
{
    NSLog(@"選擇的 btn : %@",btn_string);
    
    if([btn_string isEqualToString:@"img_back"])
    {
        NSLog(@"後退");
        [pinArray removeLastObject];
        [self clearPinView:@"clearLastPin"];
        return;
    }
    else if([btn_string isEqualToString:@"img_clear"])
    {
        NSLog(@"清除");
        [pinArray removeAllObjects];
        [self clearPinView:@"clearAllPin"];
        return;
    }
    //
    if (pinArray.count>=8) {
        [self alertContrlOfTitle:@"" andMsg:@"Error"];
    }
    else
    {
        [pinArray addObject:btn_string];
        [self compare_pin_imgValue:pinArray.count andImgIs:btn_string];
    }
//    NSLog(@"%@",pinArray);
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    // Do any additional setup after loading the view.
    
    errorTimes = 0;
    
    [self set_ToolBar];
    [self set_titleView:@"Security Token Activation"];
    
    //pinView
    pinArray = [[NSMutableArray alloc] init];
    [self set_pinView];
    
    //main text
    UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pin_view.frame)+10, CGRectGetWidth(self.view.frame), 22)];
    mainLabel.text = mainText;
    mainLabel.font = [UIFont systemFontOfSize:14];
    mainLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mainLabel];
    
    //second text
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(mainLabel.frame)+10, CGRectGetWidth(self.view.frame), 12)];
    secondLabel.text = secondText;
    secondLabel.font = [UIFont systemFontOfSize:12];
    secondLabel.numberOfLines = 0;
    secondLabel.lineBreakMode = NSLineBreakByWordWrapping;
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:secondLabel];
    
    //動態鍵盤-置中
    CGFloat bottom_btn_h = 50;
    CGFloat space =CGRectGetHeight(self.view.frame)-CGRectGetMaxY(secondLabel.frame)-bottom_btn_h;
    CGFloat ori_y = CGRectGetMaxY(secondLabel.frame);
//    NSLog(@"%f:%f",space,ori_y);
    
    [self set_activity_keyBoard_View:space andOri_y:ori_y];
    
    //btn : 確認 / 取消 : min 50h
    [self set_bottom_btn:bottom_btn_h];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - toolBar 
- (void)set_ToolBar
{
    float status_bar_h = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    //toolbar
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, status_bar_h, self.view.frame.size.width, 44)];
    toolBar.backgroundColor = [UIColor blueColor];
    [self.view addSubview:toolBar];
    
    //logo main
    CGFloat center_logo_w = 130;
    CGFloat center_logo_h = 30;
    CGFloat imgViewOri_x = (CGRectGetWidth(toolBar.frame)-center_logo_w)/2;
    CGFloat imgViewOri_y = (CGRectGetHeight(toolBar.frame)-center_logo_h)/2;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewOri_x, imgViewOri_y, center_logo_w, center_logo_h)];
    imgView.backgroundColor = [UIColor redColor];
    imgView.image = [UIImage imageNamed:@"Logo_main.png"];
    [toolBar addSubview:imgView];
    
}

- (void)back_activity
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - set title
- (void)set_titleView:(NSString *)title
{
    
    //horizontal title 30 point 好了
    CGRect horTitle_frame = CGRectMake(0, CGRectGetMaxY(toolBar.frame), CGRectGetWidth(toolBar.frame), 30);
    hor_title = [[UILabel alloc] initWithFrame:horTitle_frame];
    hor_title.backgroundColor = [UIColor redColor];
    hor_title.text = title;
    hor_title.textAlignment = NSTextAlignmentCenter;
    hor_title.backgroundColor = [UIColor colorWithRed:0 green:146.0/255.0 blue:197.0/255.0 alpha:.7];
    hor_title.textColor = [UIColor whiteColor];
    [self.view addSubview:hor_title];
}

#pragma mark - 輸入筐的顯示
- (void)set_pinView
{
    //
    /*輸入誆
     用戶輸入號碼，會於該位置顯示，並經過一秒後轉成 『*』 圖片
     */
    CGFloat as_ori_x = 40;
    CGFloat as_ori_y = CGRectGetMaxY(hor_title.frame)+10;
    CGFloat as_w = CGRectGetWidth(self.view.frame)-as_ori_x*2;
    //每個 as_view 的圖片大小
    as_img_padding = 5;
    as_img_size = (as_w-9*as_img_padding)/8;
    //設定 as_view 的高度為 (內容圖片高度+10)
    CGFloat as_h = as_img_size + as_img_padding*2;
    pin_view = [[UIView alloc] initWithFrame:CGRectMake(as_ori_x, as_ori_y, as_w, as_h)];
    pin_view.backgroundColor = [UIColor whiteColor];
    pin_view.layer.cornerRadius = 7;
    [self.view addSubview:pin_view];
    
    //應該先設定好位置，然後將圖片放入才對
    UIColor *default_color = [UIColor clearColor];
    
    //
    CGFloat selectImg_ori_x = as_img_padding;
    CGFloat selectImg_ori_y = as_img_padding;
    CGRect slectImg_1_Frame = CGRectMake(selectImg_ori_x, selectImg_ori_y, as_img_size, as_img_size);
    selectedImg_1 = [[UIImageView alloc] initWithFrame:slectImg_1_Frame];
    selectedImg_1.backgroundColor = default_color;
    [pin_view addSubview:selectedImg_1];
    
    //
    selectImg_ori_x = CGRectGetMaxX(slectImg_1_Frame) + as_img_padding;
    selectImg_ori_y = as_img_padding;
    CGRect slectImg_2_Frame = CGRectMake(selectImg_ori_x, selectImg_ori_y, as_img_size, as_img_size);
    selectedImg_2 = [[UIImageView alloc] initWithFrame:slectImg_2_Frame];
    selectedImg_2.backgroundColor = default_color;
    [pin_view addSubview:selectedImg_2];
    
    //
    selectImg_ori_x = CGRectGetMaxX(slectImg_2_Frame) + as_img_padding;
    selectImg_ori_y = as_img_padding;
    CGRect slectImg_3_Frame = CGRectMake(selectImg_ori_x, selectImg_ori_y, as_img_size, as_img_size);
    selectedImg_3 = [[UIImageView alloc] initWithFrame:slectImg_3_Frame];
    selectedImg_3.backgroundColor = default_color;
    [pin_view addSubview:selectedImg_3];
    
    //
    selectImg_ori_x = CGRectGetMaxX(slectImg_3_Frame) + as_img_padding;
    selectImg_ori_y = as_img_padding;
    CGRect slectImg_4_Frame = CGRectMake(selectImg_ori_x, selectImg_ori_y, as_img_size, as_img_size);
    selectedImg_4 = [[UIImageView alloc] initWithFrame:slectImg_4_Frame];
    selectedImg_4.backgroundColor = default_color;
    [pin_view addSubview:selectedImg_4];
    
    //
    selectImg_ori_x = CGRectGetMaxX(slectImg_4_Frame) + as_img_padding;
    selectImg_ori_y = as_img_padding;
    CGRect slectImg_5_Frame = CGRectMake(selectImg_ori_x, selectImg_ori_y, as_img_size, as_img_size);
    selectedImg_5 = [[UIImageView alloc] initWithFrame:slectImg_5_Frame];
    selectedImg_5.backgroundColor = default_color;
    [pin_view addSubview:selectedImg_5];
    
    //
    selectImg_ori_x = CGRectGetMaxX(slectImg_5_Frame) + as_img_padding;
    selectImg_ori_y = as_img_padding;
    CGRect slectImg_6_Frame = CGRectMake(selectImg_ori_x, selectImg_ori_y, as_img_size, as_img_size);
    selectedImg_6 = [[UIImageView alloc] initWithFrame:slectImg_6_Frame];
    selectedImg_6.backgroundColor = default_color;
    [pin_view addSubview:selectedImg_6];
    
    //
    selectImg_ori_x = CGRectGetMaxX(slectImg_6_Frame) + as_img_padding;
    selectImg_ori_y = as_img_padding;
    CGRect slectImg_7_Frame = CGRectMake(selectImg_ori_x, selectImg_ori_y, as_img_size, as_img_size);
    selectedImg_7 = [[UIImageView alloc] initWithFrame:slectImg_7_Frame];
    selectedImg_7.backgroundColor = default_color;
    [pin_view addSubview:selectedImg_7];
    
    //
    selectImg_ori_x = CGRectGetMaxX(slectImg_7_Frame) + as_img_padding;
    selectImg_ori_y = as_img_padding;
    CGRect slectImg_8_Frame = CGRectMake(selectImg_ori_x, selectImg_ori_y, as_img_size, as_img_size);
    selectedImg_8 = [[UIImageView alloc] initWithFrame:slectImg_8_Frame];
    selectedImg_8.backgroundColor = default_color;
    [pin_view addSubview:selectedImg_8];
}

#pragma mark 放置 user 所選的號碼
- (void)compare_pin_imgValue:(NSInteger)currentPosition andImgIs:(NSString *)imgName
{
    float delayTime = .15;
    switch (currentPosition) {
        case 1:
            selectedImg_1.image = [UIImage imageNamed:imgName];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(delayToMask:) userInfo:selectedImg_1 repeats:NO];
            break;
        case 2:
            selectedImg_2.image = [UIImage imageNamed:imgName];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(delayToMask:) userInfo:selectedImg_2 repeats:NO];
            break;
        case 3:
            selectedImg_3.image = [UIImage imageNamed:imgName];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(delayToMask:) userInfo:selectedImg_3 repeats:NO];
            break;
        case 4:
            selectedImg_4.image = [UIImage imageNamed:imgName];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(delayToMask:) userInfo:selectedImg_4 repeats:NO];
            break;
        case 5:
            selectedImg_5.image = [UIImage imageNamed:imgName];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(delayToMask:) userInfo:selectedImg_5 repeats:NO];
            break;
        case 6:
            selectedImg_6.image = [UIImage imageNamed:imgName];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(delayToMask:) userInfo:selectedImg_6 repeats:NO];
            break;
        case 7:
            selectedImg_7.image = [UIImage imageNamed:imgName];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(delayToMask:) userInfo:selectedImg_7 repeats:NO];
            break;
        case 8:
            selectedImg_8.image = [UIImage imageNamed:imgName];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(delayToMask:) userInfo:selectedImg_8 repeats:NO];
            break;
            
        default:
            break;
    }
}

- (void)delayToMask:(NSTimer *)timer
{
    UIImageView *tempImgView = timer.userInfo;;
    tempImgView.image = [UIImage imageNamed:@"img_star.png"];
}

#pragma mark 清除號碼
- (void)clearPinView:(NSString *)action
{
    if ([action isEqualToString:@"clearAllPin"]) {
        selectedImg_1.image = NULL;
        selectedImg_2.image = NULL;
        selectedImg_3.image = NULL;
        selectedImg_4.image = NULL;
        selectedImg_5.image = NULL;
        selectedImg_6.image = NULL;
        selectedImg_7.image = NULL;
        selectedImg_8.image = NULL;
    }
    else if ([action isEqualToString:@"clearLastPin"])
    {
        switch (pinArray.count+1) {
            case 1:
                selectedImg_1.image = NULL;
                break;
            case 2:
                selectedImg_2.image = NULL;
                break;
            case 3:
                selectedImg_3.image = NULL;
                break;
            case 4:
                selectedImg_4.image = NULL;
                break;
            case 5:
                selectedImg_5.image = NULL;
                break;
            case 6:
                selectedImg_6.image = NULL;
                break;
            case 7:
                selectedImg_7.image = NULL;
                break;
            case 8:
                selectedImg_8.image = NULL;
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - alert control
- (void)alertContrlOfTitle:(NSString *)title andMsg:(NSString *)msg
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)alert_and_finshView:(NSString *)title andMsg:(NSString *)msg
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 初始化動態鍵盤
- (void)set_activity_keyBoard_View:(CGFloat)space andOri_y:(CGFloat)ori_y
{
    keyboardVC *temp = [[keyboardVC alloc] init];
    temp._delegate = self;
    temp.side_interval = 10;
    temp.btn_interval = 15;
    temp.btn_size = (CGRectGetWidth(self.view.frame)-2*temp.side_interval - 5*temp.btn_interval)/4;
    temp.kb_size = CGSizeMake(CGRectGetWidth(self.view.frame)-2*temp.side_interval, temp.btn_size*3 + 4*temp.btn_interval);
    
    
    CGRect contentFrame = CGRectMake(0, ori_y+(space-temp.kb_size.height)/2, CGRectGetWidth(self.view.frame), temp.kb_size.height);
    temp.view.frame = contentFrame;
    [self.view addSubview:temp.view];
    [self addChildViewController:temp];
    
}

#pragma mark - 設定最下方 btn
- (void)set_bottom_btn:(CGFloat)btn_h
{
    CGFloat bottom_h        = btn_h;
    CGFloat bottom_w        = CGRectGetWidth(self.view.frame)/2;
    CGFloat bottom_ori_y    = CGRectGetMaxY(self.view.frame)-bottom_h;
    
    UIButton *confirm_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirm_btn.frame = CGRectMake(0, bottom_ori_y, bottom_w, bottom_h);
    confirm_btn.backgroundColor = [UIColor greenColor];
    [confirm_btn setTitle:@"確認" forState:UIControlStateNormal];
    [confirm_btn addTarget:self action:@selector(confirm_activity:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm_btn];
    
    UIButton *cancel_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel_btn.frame = CGRectMake(CGRectGetMaxX(confirm_btn.frame), bottom_ori_y, bottom_w, bottom_h);
    cancel_btn.backgroundColor = [UIColor redColor];
    [cancel_btn setTitle:@"取消" forState:UIControlStateNormal];
    [cancel_btn addTarget:self action:@selector(cancel_activity:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel_btn];
}

#pragma mark bottom activity
- (void)confirm_activity:(id)sender
{
//    activity_serial
    if (pinArray.count!=8) {
        [self alertContrlOfTitle:@"" andMsg:@"未滿8碼"];
        return;
    }
    activity_serial = [[self imgToCode] componentsJoinedByString:@""];
    NSLog(@"final_pass:%@",activity_serial);
    
    if ([activity_serial isEqualToString:passWord]) {
        [self cancel_activity:nil];
        return;
    }
    else
    {
        errorTimes++;
    }
    
    if (errorTimes>=3) {
        [self alert_and_finshView:@"" andMsg:@"超過錯誤次數 3，系統關閉"];
    }
    else
    {
        [self alertContrlOfTitle:@"" andMsg:[NSString stringWithFormat:@"密碼錯誤 : %d 次",errorTimes]];
    }
}

- (void)cancel_activity:(id)sedner
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - pin img 轉換成代碼
- (NSMutableArray *)imgToCode
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i=0; i<pinArray.count; i++) {
        NSString *temp = @"";
        if ([[pinArray objectAtIndex:i] isEqualToString:@"img_0"]) {
            temp = @"0";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_1"])
        {
            temp = @"1";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_2"])
        {
            temp = @"2";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_3"])
        {
            temp = @"3";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_4"])
        {
            temp = @"4";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_5"])
        {
            temp = @"5";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_6"])
        {
            temp = @"6";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_7"])
        {
            temp = @"7";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_8"])
        {
            temp = @"8";
        }
        else if ([[pinArray objectAtIndex:i] isEqualToString:@"img_9"])
        {
            temp = @"9";
        }
        [tempArray addObject:temp];
    }
    return tempArray;
}

@end
