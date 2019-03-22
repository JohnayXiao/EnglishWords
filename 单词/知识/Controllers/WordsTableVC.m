//
//  WordsTableVC.m
//  知识
//
//  Created by Johnay  on 2018/4/24.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "WordsTableVC.h"
#import "PlayModel.h"
#import <AVFoundation/AVFoundation.h>

@interface WordsTableVC ()
{
    int countR;
    int countG;
    int countB;
}
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *plistName;
@property (nonatomic, assign) NSInteger plistNum;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *rgbDataSource;
@property (nonatomic, strong) NSIndexPath *indexPath1;
@property (nonatomic, strong) NSIndexPath *indexPath2;

@property (nonatomic, assign) BOOL switchBool;

@end

@implementation WordsTableVC

- (instancetype)initTitleName:(NSString *)titleName andPlistName:(NSString *)plistName andPlistNum:(NSInteger)plistNum {
    
    if (self = [super init]) {
        
        _titleName = titleName;
        _plistName = plistName;
        _plistNum = plistNum;
    }
    
    return self;
    
}
- (NSMutableArray *)dataSource {
    
    if (_dataSource == nil) {
        
        _dataSource = @[].mutableCopy;
        
        countR = 0;
        countG = 0;
        countB = 0;
        
        //自动填写名字啦。。
        for (int i = 0; i < self.plistNum; i++) {
            
            // 加载plist文件
            NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%d.plist", self.plistName, i + 1] ofType:nil];
            
            NSMutableArray *fileArr = [NSMutableArray arrayWithContentsOfFile:filePath];
            
            NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            
            NSString *fileDataPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.plist", self.plistName, i + 1]];
            
            //如果文件路径存在，获取里面答案
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
            
            NSMutableArray *tempArr = @[].mutableCopy;
            
            for (NSDictionary *dic in fileArr) {
                // 字典转模型
                PlayModel *p = [PlayModel playModelWithDic:dic];
                
                [tempArr addObject:p];
                
                if ([p.status isEqualToString:@"F"]) {
                    
                    countR ++;
                    
                }else if ([p.status isEqualToString:@"Y"]) {
                    
                    countG ++;
                    
                }else {
                    
                    countB ++;
                }
            }
            
            [_dataSource addObject:tempArr];
        }
       
        self.title = [NSString stringWithFormat:@"R:%d G:%d B:%d",countR, countG, countB];
    }
    
    return _dataSource;
}

- (NSMutableArray *)rgbDataSource {
    
    if (_rgbDataSource == nil) {
        
        _rgbDataSource = @[].mutableCopy;
    
        NSMutableArray *redArr = @[].mutableCopy;
        NSMutableArray *greeArr = @[].mutableCopy;
        NSMutableArray *blueArr = @[].mutableCopy;
        
                //自动填写名字啦。。
        for (int i = 0; i < self.plistNum; i++) {
            
            // 加载plist文件
            NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%d.plist", self.plistName, i + 1] ofType:nil];
            
            NSMutableArray *fileArr = [NSMutableArray arrayWithContentsOfFile:filePath];
            
            NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            
            NSString *fileDataPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.plist", self.plistName, i + 1]];
            
            //如果文件路径存在，获取里面答案
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
                
                if ([p.status isEqualToString:@"F"]) {
                    
                    [redArr addObject:p];
                    
                }else if ([p.status isEqualToString:@"Y"]) {
                    
                    [greeArr addObject:p];
                    
                }else {
                    
                    [blueArr addObject:p];
                }
            }
            
        }
        
        countR = (int) redArr.count;
        countG = (int) greeArr.count;
        countB = (int) blueArr.count;
        
        self.title = [NSString stringWithFormat:@"R:%d G:%d B:%d",countR, countG, countB];
    
        
        if (countR) [_rgbDataSource addObject:redArr];
        if (countG) [_rgbDataSource addObject:greeArr];
        if (countB) [_rgbDataSource addObject:blueArr];
    }
    
    return _rgbDataSource;
}

- (void)SwitchAction {
    
    
    
//    for (NSIndexPath *indexPath in visiblePaths)
//    {
//        //获取到的indexpath为屏幕上的cell的indexpath
//
//        NSLog(@"section:%ld row:%ld\n", indexPath.section, indexPath.row);
//    }
    
    
    if(self.switchBool) {
        
        if (self.indexPath1.section == 0 && self.indexPath1.row == 0) {

            self.indexPath1 = [self.tableView indexPathsForVisibleRows][0];

        }else {

            self.indexPath1 = [self.tableView indexPathsForVisibleRows][1];
        }
        
    }else {
        
        if (self.indexPath2.section == 0 && self.indexPath2.row == 0) {

            self.indexPath2 = [self.tableView indexPathsForVisibleRows][0];

        }else {

            self.indexPath2 = [self.tableView indexPathsForVisibleRows][1];
        }
        
    }
    
    
    self.switchBool = !self.switchBool;
    
    [[NSUserDefaults standardUserDefaults] setBool:self.switchBool forKey:@"SwitchBoolKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.tableView reloadData];
    
//    if (self.lastIndexPath.section == 0 && self.lastIndexPath.row == 0) {
//
//
//
//    }else {
//
//        //***************方法二***************//
//        [self.tableView setContentOffset:self.lastContentOffSet animated:NO];
//    }

    //***************方法三***************//
//    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
    
    if (self.switchBool) {
        
        [self.tableView scrollToRowAtIndexPath:self.indexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }else {
        
        [self.tableView scrollToRowAtIndexPath:self.indexPath2 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    self.indexPath2 = [NSIndexPath indexPathForRow:0 inSection:0];
    self.switchBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"SwitchBoolKey"];
    self.title = @"哈哈哈";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Switch" style:UIBarButtonItemStylePlain target:self action:@selector(SwitchAction)];
    
    UILabel *poemLB = [[UILabel alloc] init];
    poemLB.numberOfLines = 0;
    poemLB.textColor = [UIColor whiteColor];
    poemLB.font = regularFontWithSize(14);
    
    poemLB.text = @"If one day you feel like crying \n Call me \n I don't promise that I will make you laugh \n But I can cry with you \n If one day you want to run away \n Don't be afraid to call me \n I don't promise to ask you to stop \n But I can run with you \n If one day you don't want to listen to anyone \n Call me \n I promise to be there for you \n And I promise to be very quiet\n But if one day you call \n And there is no answer \n Come fast to see me \n Perhaps I need you\n\nOh my god!\n It’s unbelievable that you can arrive here\nNow you should stop^_^\n\n\n  \n\n\n\n\n\n\n\n\n\n\n\n";
    [poemLB sizeToFit];
    poemLB.textAlignment = NSTextAlignmentCenter;
    
    self.tableView.backgroundView = poemLB;
    self.view.backgroundColor = RGBCOLOR(74, 89, 172);
    
    UILabel *footV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XJ_ScreenWidth, FitValue(20))];
    footV.text = @"^_^The End^_^";
    footV.textColor = [UIColor whiteColor];
    footV.font = regularFontWithSize(10);
    footV.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = footV;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.switchBool ? self.dataSource.count : self.rgbDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.switchBool ? [self.dataSource[section] count] : [self.rgbDataSource[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    // Configure the cell...
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    
    
    PlayModel *model = self.switchBool ?self.dataSource[indexPath.section][indexPath.row] : self.rgbDataSource[indexPath.section][indexPath.row];
    
    if ([model.status isEqualToString:@"F"]) {
        
        cell.backgroundColor = RGBCOLOR(250, 90, 79);
        
    }else if ([model.status isEqualToString:@"Y"]) {
        
        cell.backgroundColor = RGBCOLOR(106, 181, 114);
        
    }else {
        
        cell.backgroundColor = RGBCOLOR(74, 89, 172);
    }
    cell.textLabel.text = model.question;
    cell.detailTextLabel.text = model.answer;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayModel *model = self.switchBool ? self.dataSource[indexPath.section][indexPath.row] : self.rgbDataSource[indexPath.section][indexPath.row];
    
    AVSpeechSynthesizer *synthesize = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:model.question];
    [synthesize speakUtterance:utterance];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//修改header的属性
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section

{

    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;

    header.contentView.backgroundColor = [UIColor clearColor];

    header.textLabel.textAlignment = NSTextAlignmentCenter;

//    header.textLabel.font = regularFontWithSize(17);

    [header.textLabel setTextColor:[UIColor whiteColor]];

}
//返回section的头部文本
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (self.switchBool) {

        NSMutableArray *mutableArray = [NSMutableArray array];
        for(int i = 1; i <= self.dataSource.count; i++) {
            [mutableArray addObject:[NSString stringWithFormat:@"%@ %d", self.titleName, i]];
        }
        return mutableArray[section];
    }

    NSMutableArray *headTitleArr = @[].mutableCopy;
    
    if (countR) [headTitleArr addObject:@"Red"];
    if (countG) [headTitleArr addObject:@"Green"];
    if (countB) [headTitleArr addObject:@"Blue"];
    
    return headTitleArr[section];


}

//返回tableViewIndex数组
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    //更改索引的背景颜色
//    tableView.sectionIndexBackgroundColor = [UIColor clearColor];

    //更改索引的背景颜色
    tableView.sectionIndexColor = [UIColor whiteColor];


    if (self.switchBool) {

        NSMutableArray *mutableArray = [NSMutableArray array];
        for(int i = 1; i <= self.dataSource.count; i++) {
            [mutableArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        return mutableArray;
    }

    NSMutableArray *sideTitleArr = @[].mutableCopy;
    
    if (countR) [sideTitleArr addObject:@"R"];
    if (countG) [sideTitleArr addObject:@"G"];
    if (countB) [sideTitleArr addObject:@"B"];
    
    return sideTitleArr;

    //使用KVC方式
//    return [self.dataSource valueForKeyPath:@"question"];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.switchBool) {
        
        self.indexPath1 = [self.tableView indexPathsForVisibleRows][0];
        
    }else {
        
        self.indexPath2 = [self.tableView indexPathsForVisibleRows][0];
    }
}
//解决cell线条显示不全
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)dealloc {
        
    NSLog(@"dealloc---%s", __func__);
}
@end
