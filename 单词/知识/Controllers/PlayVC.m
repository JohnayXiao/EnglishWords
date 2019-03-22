//
//  PlayVC.m
//  知识
//
//  Created by Johnay  on 2018/2/8.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "PlayVC.h"
#import "PlayModel.h"
#import "UINavigationBar+Awesome.h"
#import "TimeTool.h"
#import "MMAlertView.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayVC ()
{
    int questionNums;
    int lastStatu;
    BOOL isFirstIn;
    double totalScore;
    double singleScore;
    
    NSString *indexKey;
    NSString *scoreKey;
    NSString *fileDataPath;
    
    UIButton *voiceBtn;
    
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *selectionsArray;

@property (nonatomic, strong) NSMutableArray *degreeArray;

@property (nonatomic, strong) AVAudioPlayer *audioplay;

@end

@implementation PlayVC

- (instancetype)initWithModel:(mainModel *)model {
    
    if (self = [super init]) {
        
        _model = model;
        
    }
    
    return self;
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = @[].mutableCopy;
        
        // 加载plist文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.plist", self.model.plistName] ofType:nil];
        
        NSMutableArray *fileArr = [NSMutableArray arrayWithContentsOfFile:filePath];
        
        
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];

        fileDataPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", self.model.plistName]];
        
        //获取答案
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileDataPath]) {
            
            // 加载plist文件
            NSArray *arr = [NSArray arrayWithContentsOfFile:fileDataPath];
            
            NSInteger index = 0;
            NSInteger fileArrCount = fileArr.count;
            for (NSDictionary *dic in arr) {
                
                if (index < fileArrCount) {
                    
                    [fileArr[index]  setValue:dic[@"status"] forKey:@"status"];
                }
                
                index ++;
            }
            
        }
        
        for (NSDictionary *dic in fileArr) {
            // 字典转模型
            PlayModel *p = [PlayModel playModelWithDic:dic];
            
            [_dataArray addObject:p];
            
        }
        
    }
    
    return  _dataArray;
}

- (NSMutableArray *)degreeArray {
    
    if (_degreeArray == nil) {
        
        _degreeArray = @[].mutableCopy;
        [_degreeArray addObject:@"学前班"];
        [_degreeArray addObject:@"幼儿园"];
        [_degreeArray addObject:@"小学"];
        [_degreeArray addObject:@"初中"];
        [_degreeArray addObject:@"高中"];
        [_degreeArray addObject:@"专科"];
        [_degreeArray addObject:@"本科"];
        [_degreeArray addObject:@"硕士"];
        [_degreeArray addObject:@"博士"];
        [_degreeArray addObject:@"博士后"];
        [_degreeArray addObject:@"国之栋梁"];
    }
    
    return _degreeArray;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];

    [self modifPlistFile];
    
    self.navigationController.navigationBarHidden = NO;

    //如果不是iPad
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//
//        [self.navigationController.navigationBar setBackgroundImage:self.backImgV.image forBarMetrics:UIBarMetricsDefault];
//    }
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;

}

- (void)changeBackImg {
    
    if (self.model.score + 0.01 < 90){
        
        self.backImgV.image = [UIImage imageNamed:@"screen1"];
        
    }else{
        
        self.backImgV.image = [UIImage imageNamed:@"screen3"];
        
    }
    
    if (!isFirstIn) {
        
        if (lastStatu != [self getCurrentDegreeStatus]) {
            
            if (self.model.score + 0.01 >= 10 && self.model.score + 0.01 < 60) {
                
                [self playSound:@"applause1"];
                
            } else if(self.model.score + 0.01 < 100){
                
                [self playSound:@"applause2"];
            }
        }
    }
    
    lastStatu = [self getCurrentDegreeStatus];
    isFirstIn = NO;
    
}

//MARK: - 入口
- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFirstIn = YES;

    self.titleLabel.text = self.model.title;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isForbidVoice"]) {
        
        [self.voiceBtn setImage:[UIImage imageNamed:@"voice1"] forState:UIControlStateNormal];
        
    }else {
        
        [self.voiceBtn setImage:[UIImage imageNamed:@"voice2"] forState:UIControlStateNormal];
        
    }
    
    WeakSelf;
    [self.voiceBtn click:^(UIView *view) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isForbidVoice"]) {
            
            [weakSelf.voiceBtn setImage:[UIImage imageNamed:@"voice1"] forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isForbidVoice"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [weakSelf playSound:@"next"];
            
            NSString *question = weakSelf.questionLabel.text;
            weakSelf.questionLabel.text = @"点我可以复读哦！";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.questionLabel.text = question;
            });
            
        } else {
            
            [weakSelf.voiceBtn setImage:[UIImage imageNamed:@"voice2"] forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isForbidVoice"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSString *question = weakSelf.questionLabel.text;
            weakSelf.questionLabel.text = @"点我可以发音哦！";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.questionLabel.text = question;
            });
        }
    }];
    
    [self.questionLabel click:^(UIView *view) {
        
        [weakSelf readEnglish];
    }];
    
    //给按钮绑定事件
    [self.selectBtn1 addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn2 addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn3 addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn4 addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.previousBtn addTarget:self action:@selector(previousBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.clearBtn addTarget:self action:@selector(clearBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化数据
    totalScore = 100.0;
    questionNums = (int)self.dataArray.count;
    self.model.count = questionNums;
    singleScore = totalScore / questionNums;
    
    self.model.index--;
    [self nextBtnAction:nil];
    
    ADD_NOTIFICATION_WITH_SEL_AND_NAME(@selector(willEnterBackGround), @"willEnterBackGround");
    
}

//MARK: - 声音播放
- (void)playSound:(NSString *)soundName {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isForbidVoice"]) {
        
        return;
    }
    
//    //用系统音量播放
//    SystemSoundID soundID;
//    // 加载文件
//    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"]];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileURL), &soundID);
//
//    // 播放短频音效
//    AudioServicesPlayAlertSound(soundID);
//
//    // 增加震动效果，如果手机处于静音状态，提醒音将自动触发震动
//    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    //用媒体音量播放
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"]];

    self.audioplay = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];

    [self.audioplay play];
}

//MARK: - 按钮点击事件
- (void)selectBtnAction:(SelectBtn *)sender {
    
    PlayModel *model = (PlayModel *)self.dataArray[self.model.index];
    
    if (![model.status isEqualToString:@"N"]) {
        
        return;
    }
    
    if ([sender.currentTitle isEqualToString:model.answer]) {
        
        [self playSound:@"good"];
        
        model.status = @"Y";
        
        if (self.selectBtn1.isEnabled && self.selectBtn2.isEnabled && self.selectBtn3.isEnabled && self.selectBtn4.isEnabled) {
            
            self.model.score += singleScore;
            
        }
        sender.selected = YES;
        [self nextBtnAction:nil];
        
    }else {
        
        [self playSound:@"fail2"];
        sender.enabled = NO;
        self.previousBtn.enabled = NO;

        if ([model.answer isEqualToString:self.selectBtn1.currentTitle]) {

            self.selectBtn1.selected = YES;
            self.selectBtn2.enabled = NO;
            self.selectBtn3.enabled = NO;
            self.selectBtn4.enabled = NO;

        }else if ([model.answer isEqualToString:self.selectBtn2.currentTitle]) {

            self.selectBtn2.selected = YES;
            self.selectBtn1.enabled = NO;
            self.selectBtn3.enabled = NO;
            self.selectBtn4.enabled = NO;

        }else if ([model.answer isEqualToString:self.selectBtn3.currentTitle]) {

            self.selectBtn3.selected = YES;
            self.selectBtn1.enabled = NO;
            self.selectBtn2.enabled = NO;
            self.selectBtn4.enabled = NO;

        }else {

            self.selectBtn4.selected = YES;
            self.selectBtn1.enabled = NO;
            self.selectBtn2.enabled = NO;
            self.selectBtn3.enabled = NO;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            model.status = @"F";
            [self nextBtnAction:nil];

        });
    }
    
    
    
}

//MARK: - 上一个下一个
- (void)previousBtnAction {
    
    self.model.index--;
    [self playSound:@"next"];
    [self setSelectBtnTitles];
}

- (void)clearBtnAction {
    
    [self playSound:@"fail"];
    // 弹窗
    NSArray *items = @[MMItemMake(@"点错啦", MMItemTypeNormal, nil),MMItemMake(@"好哒", MMItemTypeHighlight, ^(NSInteger index) {
        
        for (PlayModel *model in self.dataArray) {
            
            model.status = @"N";
        }
        
        [self playSound:@"clear"];
        self.model.index = -1;
        self.model.score = 0;
        isFirstIn = YES;
        [self nextBtnAction:nil];
        
    })];
    
    [[[MMAlertView alloc] initWithTitle:@"亲" detail:@"这可是重新开始的操作哦^_^" items:items] showWithBlock:nil];
      
}

- (void)nextBtnAction:(DirectionBtn *)sender {
    
    self.model.index++;
    
    if (sender) {
        
        [self playSound:@"next"];
    }
    
    if (self.model.index == questionNums) {

        self.model.index--;
        isFirstIn = YES;
        self.nextBtn.enabled = YES;

        
        NSString *alertTitle;
        NSString *alertStr;
        
        if (self.model.score + 0.01 >= totalScore) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isShowJohnayVC"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self playSound:@"greatVoice"];
            
            alertTitle = @"国之栋梁";
            alertStr = @"太厉害了，国家因为有您而骄傲！^_^";
            
        }else if(self.model.score + 0.01 >= 60 ) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isShowJohnayVC"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self playSound:@"goodVoice"];
            int current = [self getCurrentDegreeStatus];
            alertTitle = self.degreeArray[current];
            alertStr = [NSString stringWithFormat:@"恭喜您，当前%@在读！革命尚未成功，请继续努力！下一次您将是国之栋梁^_^", alertTitle];
            
        }else {
            
            [self playSound:@"failVoice"];
            int current = [self getCurrentDegreeStatus];
            alertTitle = self.degreeArray[current];
            alertStr = [NSString stringWithFormat:@"很遗憾，您%@没能毕业！失败是成功它妈，请继续努力！下一次您将金榜提名^_^", alertTitle];

        }
        
        // 弹窗
        NSArray *items = @[MMItemMake(@"好哒", MMItemTypeHighlight, nil)];
        
        
        [[[MMAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@(%.2f分)",alertTitle, self.model.score] detail:alertStr items:items] showWithBlock:nil];
        
    }else {
        
        [self setSelectBtnTitles];
    }
    
}


//MARK: - 随机生成四个不重复的答案
- (void)getAnswers {
    
    self.selectionsArray = @[].mutableCopy;
    
    //先将正确答案放进去
    [self.selectionsArray addObject:((PlayModel *)self.dataArray[self.model.index]).answer];
    
    while (self.selectionsArray.count < 4) {
        
        int i = arc4random_uniform(questionNums);
        
        PlayModel *model = (PlayModel *)self.dataArray[i];
        
        int j = 0;
        while (j < self.selectionsArray.count)  {
            
            if ([model.answer isEqualToString:self.selectionsArray[j]]) {
                
                break;
                
            }
            
            j++;
        }
        
        if (j == self.selectionsArray.count) {
            
            [self.selectionsArray addObject:model.answer];
        }
    }
}

//MARK: - 获取状态
- (int)getCurrentDegreeStatus {
    
    return (int)((self.model.score + 0.01) / 10);
}


- (void)readEnglish {
    
    AVSpeechSynthesizer *synthesize = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.questionLabel.text];
    [synthesize speakUtterance:utterance];
}
//MARK: - 设置答案
- (void)setSelectBtnTitles {
    
    [self changeBackImg];
    
    [self getAnswers];
    
    //先重置按钮状态
    self.selectBtn1.selected = NO;
    self.selectBtn1.enabled = YES;
    self.selectBtn2.selected = NO;
    self.selectBtn2.enabled = YES;
    self.selectBtn3.selected = NO;
    self.selectBtn3.enabled = YES;
    self.selectBtn4.selected = NO;
    self.selectBtn4.enabled = YES;
    
    //问题label
    self.numberLabel.text = [NSString stringWithFormat:@"%zd.", self.model.index + 1];
    self.questionLabel.text = [NSString stringWithFormat:@"%@", ((PlayModel *)self.dataArray[self.model.index]).question];
    
    //读英语啊。。。。
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isForbidVoice"]) {
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            AVSpeechSynthesizer *synthesize = [[AVSpeechSynthesizer alloc] init];
//            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.questionLabel.text];
//
//            [synthesize speakUtterance:utterance];
//
//        });
        //这里是关键，点击按钮后先取消之前的操作，再进行需要进行的操作
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(readEnglish) object:nil];
        [self performSelector:@selector(readEnglish)withObject:nil afterDelay:0.75f];
        
    }
    
    NSInteger lenth = self.questionLabel.text.length;
    
    if (lenth < 18 * 7) {
        
        self.questionLabel.font = regularFontWithSize(20);
        
    }else {
        
        NSInteger level = (lenth - 18 * 7) / 18 + 1;
        
        if (IS_SCREENH_736) {
            
            level -= 1;
            
            if (level < 0) {
                
                level = 0;
            }
            
        } else if(IS_SCREENH_812 || IS_IPAD) {
            
            level -= 3;
            
            if (level < 0) {
                
                level = 0;
            }
            
        }
        
        if (level > 7) {
            
            level = 7;
        }
        self.questionLabel.font = regularFontWithSize(20 - level);
    }
    [self.clearBtn setTitle:[NSString stringWithFormat:@"%zd/%d", self.model.index + 1, questionNums] forState:0];
    
    //当前
    int current = [self getCurrentDegreeStatus];

    self.topLabel.text = [NSString stringWithFormat:@"当前：%@（%.2f）", self.degreeArray[current], self.model.score];
    
    //目标
    int next = current + 1;
    
    if (next != 11) {
        
        if(next < 10) {
            
            self.bottomLabel.text = [NSString stringWithFormat:@"目标：%@（%.2f）", self.degreeArray[next], next * 10.0];
            
        }else {
            
            self.bottomLabel.text = [NSString stringWithFormat:@"目标：%@（%.2f）", self.degreeArray[next], next * 10.0];
        }
        
    }else {
        
        self.bottomLabel.text = @"登峰造极，天下无敌！";
    }
    
//    NSLog(@"score:%f   current: %d", self.model.score, current);
    
    PlayModel *model = self.dataArray[self.model.index];
    
    //随机确定正确答案的位置
    int rightIndex = arc4random_uniform(4) + 1;
    
    if (rightIndex == 1) {
        
        [self.selectBtn1 setTitle:self.selectionsArray[0] forState:0];
        [self.selectBtn2 setTitle:self.selectionsArray[1] forState:0];
        [self.selectBtn3 setTitle:self.selectionsArray[2] forState:0];
        [self.selectBtn4 setTitle:self.selectionsArray[3] forState:0];
        
        if ([model.status isEqualToString:@"Y"]) {
            
            self.selectBtn1.selected = YES;
            
        }else if([model.status isEqualToString:@"F"]) {
            
            self.selectBtn1.selected = YES;
            self.selectBtn2.enabled = NO;
            self.selectBtn3.enabled = NO;
            self.selectBtn4.enabled = NO;

        }
        
    }else if (rightIndex == 2) {
        
        [self.selectBtn1 setTitle:self.selectionsArray[1] forState:0];
        [self.selectBtn2 setTitle:self.selectionsArray[0] forState:0];
        [self.selectBtn3 setTitle:self.selectionsArray[2] forState:0];
        [self.selectBtn4 setTitle:self.selectionsArray[3] forState:0];
        
        if ([model.status isEqualToString:@"Y"]) {
            
            self.selectBtn2.selected = YES;
            
        }else if([model.status isEqualToString:@"F"]) {
            
            self.selectBtn1.enabled = NO;
            self.selectBtn2.selected = YES;
            self.selectBtn3.enabled = NO;
            self.selectBtn4.enabled = NO;
            
        }
        
    }else if (rightIndex == 3) {
        
        [self.selectBtn1 setTitle:self.selectionsArray[1] forState:0];
        [self.selectBtn2 setTitle:self.selectionsArray[2] forState:0];
        [self.selectBtn3 setTitle:self.selectionsArray[0] forState:0];
        [self.selectBtn4 setTitle:self.selectionsArray[3] forState:0];
        
        if ([model.status isEqualToString:@"Y"]) {
            
            self.selectBtn3.selected = YES;
            
        }else if([model.status isEqualToString:@"F"]) {
            
            self.selectBtn1.enabled = NO;
            self.selectBtn2.enabled = NO;
            self.selectBtn3.selected = YES;
            self.selectBtn4.enabled = NO;
            
        }
        
    }else {
        
        [self.selectBtn1 setTitle:self.selectionsArray[1] forState:0];
        [self.selectBtn2 setTitle:self.selectionsArray[2] forState:0];
        [self.selectBtn3 setTitle:self.selectionsArray[3] forState:0];
        [self.selectBtn4 setTitle:self.selectionsArray[0] forState:0];
        
        if ([model.status isEqualToString:@"Y"]) {
            
            self.selectBtn4.selected = YES;
            
        }else if([model.status isEqualToString:@"F"]) {
            
            self.selectBtn1.enabled = NO;
            self.selectBtn2.enabled = NO;
            self.selectBtn3.enabled = NO;
            self.selectBtn4.selected = YES;
            
        }
    }
    
    //底部按钮状态控制
    self.previousBtn.enabled = self.model.index;
    
    self.nextBtn.enabled = ![model.status isEqualToString:@"N"];
    
    self.clearBtn.enabled = self.previousBtn.isEnabled || self.nextBtn.isEnabled;
    
    self.topLabel.textColor = self.clearBtn.enabled ? [UIColor whiteColor] : DisableColor;
    self.bottomLabel.textColor = self.topLabel.textColor;
    
}
//MARK: - 修改plist文件
- (void)modifPlistFile {
    
    if (self.refreshBlock) {
        
        self.refreshBlock();
    }
    
    NSMutableArray *arrM = @[].mutableCopy;
    
    for (PlayModel *model in self.dataArray) {
        
        NSDictionary *dic = @{@"status" : model.status};
        [arrM addObject:dic];
    }
    
    [arrM writeToFile:fileDataPath atomically:YES];
}

#pragma mark - 获取屏幕截图

- (UIImage *)getNormalImage:(UIView *)view {
    
    UIGraphicsBeginImageContext(CGSizeMake(XJ_ScreenWidth, XJ_ScreenHeight));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}



- (void)willEnterBackGround {
    
    [self modifPlistFile];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    NSLog(@"dealloc---%s", __func__);
}

@end
