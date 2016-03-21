//
//  keyboardVC.m
//  webtest
//
//  Created by jhaoheng on 2016/3/21.
//  Copyright © 2016年 max. All rights reserved.
//

#import "keyboardVC.h"

@interface keyboardVC ()

@end

@implementation keyboardVC
@synthesize _delegate;

@synthesize side_interval,btn_interval,btn_size;
@synthesize kb_size;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    CGRect keyboard_Frame = CGRectMake(side_interval, side_interval, kb_size.width, kb_size.height);
    keyboardView = [[UIView alloc] initWithFrame:keyboard_Frame];
    keyboardView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:keyboardView];
    
    //
    [self set_random_go];
    //
    [self set_btnFrame];
    
//    NSLog(@"kb_h:%f",kb_size.height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 進行隨機變數
- (void)set_random_go
{
    /*
     把圖塞入陣列，先用隨機判斷一次
     img_1,img_2,img_3...
     */
    imgArray = [[NSMutableArray alloc] initWithObjects:
                @"img_1",
                @"img_2",
                @"img_3",
                @"img_4",
                @"img_5",
                @"img_6",
                @"img_7",
                @"img_8",
                @"img_9",
                @"img_0",
                nil];
    randomArray = [[NSMutableArray alloc] init];
    int num = (int)imgArray.count;
    for (int i=0; i<num; i++) {
        NSUInteger randomIndex = arc4random() % [imgArray count];
        [randomArray addObject:[imgArray objectAtIndex:randomIndex]];
        [imgArray removeObject:[imgArray objectAtIndex:randomIndex]];
    }
    
    /*
     將 『全部清除』、『後退鍵』放入 8/11
     */
    [randomArray insertObject:@"img_clear" atIndex:8];
    [randomArray insertObject:@"img_back" atIndex:11];
//    NSLog(@"%@",randomArray);
}

#pragma mark - 設定 btn
- (void)set_btnFrame
{
    /*
     設定每個按鈕的 frame
     */
    //第一層
    CGRect btn1_frame = CGRectMake(btn_interval, btn_interval, btn_size, btn_size);
    CGRect btn2_frame = CGRectMake(CGRectGetMaxX(btn1_frame)+btn_interval, CGRectGetMinY(btn1_frame), btn_size, btn_size);
    CGRect btn3_frame = CGRectMake(CGRectGetMaxX(btn2_frame)+btn_interval, CGRectGetMinY(btn2_frame), btn_size, btn_size);
    CGRect btn4_frame = CGRectMake(CGRectGetMaxX(btn3_frame)+btn_interval, CGRectGetMinY(btn3_frame), btn_size, btn_size);
    //第二層
    CGRect btn5_frame = CGRectMake(btn_interval, CGRectGetMaxY(btn1_frame)+btn_interval, btn_size, btn_size);
    CGRect btn6_frame = CGRectMake(CGRectGetMaxX(btn5_frame)+btn_interval, CGRectGetMinY(btn5_frame), btn_size, btn_size);
    CGRect btn7_frame = CGRectMake(CGRectGetMaxX(btn6_frame)+btn_interval, CGRectGetMinY(btn6_frame), btn_size, btn_size);
    CGRect btn8_frame = CGRectMake(CGRectGetMaxX(btn7_frame)+btn_interval, CGRectGetMinY(btn7_frame), btn_size, btn_size);
    //第三層
    CGRect btn9_frame = CGRectMake(btn_interval, CGRectGetMaxY(btn5_frame)+btn_interval, btn_size, btn_size);
    CGRect btn10_frame = CGRectMake(CGRectGetMaxX(btn9_frame)+btn_interval, CGRectGetMinY(btn9_frame), btn_size, btn_size);
    CGRect btn11_frame = CGRectMake(CGRectGetMaxX(btn10_frame)+btn_interval, CGRectGetMinY(btn10_frame), btn_size, btn_size);
    CGRect btn12_frame = CGRectMake(CGRectGetMaxX(btn11_frame)+btn_interval, CGRectGetMinY(btn11_frame), btn_size, btn_size);
    
    //編成陣列
    NSMutableArray *positions = [[NSMutableArray alloc] init];
    [positions addObject:[NSValue valueWithCGRect:btn1_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn2_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn3_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn4_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn5_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn6_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn7_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn8_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn9_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn10_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn11_frame]];
    [positions addObject:[NSValue valueWithCGRect:btn12_frame]];
    
    [self set_btn:positions];
}

- (void)set_btn:(NSMutableArray *)positions
{
    for (int i=0; i<positions.count; i++) {
        CGRect btnRect = [[positions objectAtIndex:i] CGRectValue];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = btnRect;
        btn.backgroundColor = [UIColor yellowColor];
        btn.layer.cornerRadius = 5;
        [btn setImage:[UIImage imageNamed:[randomArray objectAtIndex:i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btn_activity:) forControlEvents:UIControlEventTouchUpInside];
        [keyboardView addSubview:btn];
    }
}

#pragma mark btn activity
- (void)btn_activity:(id)sender
{
    UIButton *btn = sender;
    
    if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_1"]]) {
        [_delegate kb_click:@"img_1"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_2"]])
    {
        [_delegate kb_click:@"img_2"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_3"]])
    {
        [_delegate kb_click:@"img_3"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_4"]])
    {
        [_delegate kb_click:@"img_4"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_5"]])
    {
        [_delegate kb_click:@"img_5"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_6"]])
    {
        [_delegate kb_click:@"img_6"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_7"]])
    {
        [_delegate kb_click:@"img_7"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_8"]])
    {
        [_delegate kb_click:@"img_8"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_9"]])
    {
        [_delegate kb_click:@"img_9"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_0"]])
    {
        [_delegate kb_click:@"img_0"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_clear"]])
    {
        [_delegate kb_click:@"img_clear"];
    }
    else if ([btn.imageView.image isEqual:[UIImage imageNamed:@"img_back"]])
    {
        [_delegate kb_click:@"img_back"];
    }
}

@end
