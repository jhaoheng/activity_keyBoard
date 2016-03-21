## 動態鍵盤

- 依據圖片 0~9 隨機排列
- 密碼輸入後，上方密碼框，自動屏蔽

## code
```
	activityKeyViewController *temp  = [[activityKeyViewController alloc]init];
	temp.mainText = @"請設定交易密碼";
	temp.secondText = @"密碼設定完成，才完成註冊程序";
	temp.passWord = @"12345678";
	temp.errorTimes = 3;
	[self presentViewController:temp animated:YES completion:nil];
```

![img](img.png)