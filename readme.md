[![Build Status](https://travis-ci.org/jhaoheng/activity_keyBoard.svg?branch=master)](https://travis-ci.org/jhaoheng/activity_keyBoard)

## 動態鍵盤

- 依據圖片 0~9 隨機排列
- 密碼輸入後，上方密碼框，自動屏蔽
- 確定密碼後，審核完畢，透過 delegate 回給父層

## 三種狀態
1. 設定密碼(進行輸入密碼兩次)

	```
	activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
    temp.mainText = @"主要標題";
    temp.secondText = @"次要標題";
    temp.AKBType = AKeyBoardType_settingPin;
    temp._delegate = self;
    [self presentViewController:temp animated:YES completion:nil];
	```
2. 驗證密碼

	```
	activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
    temp.mainText = @"主要標題";
    temp.secondText = @"次要標題";
    temp.AKBType = AKeyBoardType_verifyPin;
    temp.passWord = @"12345678";
    temp.errorTimes_limited = 3;
    temp._delegate = self;
    [self presentViewController:temp animated:YES completion:nil];
	```
3. 重設密碼(驗證密碼x1，輸入密碼x2)

	```
		activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
	    temp.mainText = @"主要標題";
	    temp.secondText = @"次要標題";
	    temp.AKBType = AKeyBoardType_resetPin;
	    temp.passWord = pw_str;
	    temp.errorTimes_limited = 3;
	    temp._delegate = self;
	    [self presentViewController:temp animated:YES completion:nil];
	```

![img](img.png)

## delegate

```
@protocol finishDelegate

-(void)AKV_finish:(NSString *)value;

@end
```

## 圖片轉代碼

- imgCodeDefine.h

**在此指定圖片轉出的 code 為何**

設定 true or false

- true  : 客制代碼
- false : 制式代碼

sample 中，預設的密碼為 '11111111'  
故，此地方設定為 false
