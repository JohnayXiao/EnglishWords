//
//  ThemeViewController.m
//  知识
//
//  Created by Johnay  on 2018/2/14.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeCell.h"
#import "UINavigationBar+Awesome.h"
#import "PlayVC.h"
#import "TimeTool.h"

#import "WordsTableVC.h"
#import "XJSuspendButton.h"

static NSString *const reuseIdentifier = @"XJMainCell";

@interface ThemeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *fileDataPath;
}

@property (nonatomic, strong) NSString *plistName;
@property (nonatomic, strong) UIImageView *backImgV;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ThemeViewController

- (instancetype)initWithTitle:(NSString *)title andPlistName:(NSString *)plistName {
    
    if (self = [super init]) {
        
        _plistName = plistName;
        self.navigationItem.title = title;
    }
    
    return self;
    
}

- (NSMutableArray *)dataSource {
    
    if (_dataSource == nil) {
        
        _dataSource = @[].mutableCopy;
        
        
        // 加载plist文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"];
        
        NSMutableArray *fileArr = [NSMutableArray arrayWithContentsOfFile:filePath];
        
        //自动填写名字啦。。
        for (int i = 0; i < fileArr.count; i++) {
            
            [fileArr[i] setObject:[NSString stringWithFormat:@"%@%d", self.plistName, i + 1] forKey:@"plistName"];
            [fileArr[i] setObject:[NSString stringWithFormat:@"%@ %d", self.navigationItem.title, i + 1] forKey:@"title"];
        }
        //如果文件存在，将操作数据合并
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileDataPath]) {
            
            // 加载plist文件
            NSArray *arr = [NSArray arrayWithContentsOfFile:fileDataPath];
            
            for (NSDictionary *dic in arr) {
                
                for (NSDictionary *dic2 in fileArr) {
                    
                    if ([dic[@"plistName"] isEqualToString:dic2[@"plistName"]]) {
                        
                        [dic2 setValue:dic[@"time"] forKey:@"time"];
                        [dic2 setValue:dic[@"index"] forKey:@"index"];
                        [dic2 setValue:dic[@"count"] forKey:@"count"];
                        [dic2 setValue:dic[@"score"] forKey:@"score"];
                        
                        break;
                    }
                }
            }
            
        }
        
        for (NSDictionary *dic in fileArr) {
            // 字典转模型
            mainModel *p = [mainModel mainModelWithDic:dic];
            
            [_dataSource addObject:p];
            
        }
        
        [self saveSortedPlist];
    }
    return _dataSource;
}



//MARK: - 入口
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.navigationController.navigationBar lt_setBackgroundColor:
    //     [ThemeColor colorWithAlphaComponent:0.0]];
    //
    
//    int imgIndex = arc4random_uniform(11) + 1;
//    NSString *imgName = [NSString stringWithFormat:@"bkImg%d", imgIndex];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:imgName] forBarMetrics:UIBarMetricsDefault];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    fileDataPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Data.plist", self.plistName]];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setValue:fangSongWithSize(20) forKey:NSFontAttributeName];
    [attributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    //    self.navigationController.navigationBarHidden = YES;
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XJ_ScreenWidth, XJ_ScreenHeight - XJ_safeBottomMargin - XJ_NavigationBarHeight)];
    self.tableV.backgroundColor = grayBgColor;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.bounces = NO;
    self.tableV.separatorStyle = 0;
    self.tableV.estimatedRowHeight = 300.0;
    //    adjustsScrollViewInsetNever(self, self.tableV);
    [self.tableV registerClass:[ThemeCell class] forCellReuseIdentifier:reuseIdentifier];
    
    UILabel *footV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XJ_ScreenWidth, FitValue(20))];
    footV.text = @"^_^The End^_^";
    footV.textColor = grayTextColor;
    footV.font = regularFontWithSize(10);
    footV.textAlignment = NSTextAlignmentCenter;
    self.tableV.tableFooterView = footV;
    
    [self.view addSubview:self.tableV];
    
    
    XJSuspendButton *susBtn = [[XJSuspendButton alloc] initWithFrame:CGRectMake(XJ_ScreenWidth - FitValue(90), XJ_ScreenHeight - XJ_NavigationBarHeight - FitValue(130), FitValue(70), FitValue(70)) isThereNavBar:YES isThereTabBar:NO isLeftOrRight:NO];
    
    if ([[NSUserDefaults standardUserDefaults] floatForKey:@"xjSuspendButtonY"]) {

        susBtn.origin = CGPointMake([[NSUserDefaults standardUserDefaults] floatForKey:@"xjSuspendButtonX"], [[NSUserDefaults standardUserDefaults] floatForKey:@"xjSuspendButtonY"]);
    }
    
    WeakSelf;
    [susBtn click:^(UIView *view) {
        
        susBtn.alpha = 1.0;
        [UIView animateWithDuration:0.5 animations:^{
            
            susBtn.alpha = 0.7;
            
        } completion:^(BOOL finished) {
            
            WordsTableVC *vc = [[WordsTableVC alloc] initTitleName:weakSelf.navigationItem.title andPlistName:weakSelf.plistName andPlistNum:weakSelf.dataSource.count];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
    }];
    [self.view addSubview:susBtn];
    
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    //计算导航栏的透明度
//    CGFloat minAlphaOffset = 0;
//    CGFloat maxAlphaOffset = XJ_ScreenWidth  / 1.34 - XJ_NavigationBarHeight;
//    CGFloat offset         = scrollView.contentOffset.y;
//    CGFloat alpha          = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
//
//    NSLog(@"alpha-----%.2f", alpha);
////    [self.navigationController.navigationBar lt_setBackgroundColor:[[ThemeColor] colorWithAlphaComponent:alpha]];
//    [self.navigationController.navigationBar lt_setBackgroundColor:RGBACOLOR(156, 212, 249, alpha)];
//
//    //根据导航栏透明度设置title
//    if (alpha > 0.5) {
//
//        self.navigationController.navigationBarHidden = NO;
//        self.navigationItem.title = @"有知识，才有魅力！";
//
//    } else {
//
//        if (alpha < 0.2) {
//
//            self.navigationController.navigationBarHidden = YES;
//            self.navigationItem.title = @"";
//        }
//
//    }
//
//
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//
//    mainModel *model = self.dataSource[indexPath.row];
//
//    return model.cellHeight;
//
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    mainModel *model = self.dataSource[indexPath.row];
    
    ThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.model = model;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    mainModel *model = self.dataSource[indexPath.row];
    PlayVC *vc = [[PlayVC alloc] initWithModel:model];
    
    vc.refreshBlock = ^() {
        
        model.time = [TimeTool getNowTimeTimestamp3];
        [self saveSortedPlist];
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


//MARK: - 修改plist文件
- (void)saveSortedPlist {
    
    
    _dataSource = [[_dataSource sortedArrayUsingComparator:^NSComparisonResult(mainModel *model1, mainModel *model2) {
        
        return [model2.time compare:model1.time]; //倒序
        
    }] mutableCopy];
    
    NSMutableArray *arrM = @[].mutableCopy;
    
    for (mainModel *model in self.dataSource) {
        
        NSDictionary *dic = @{@"plistName" : model.plistName, @"time" : model.time, @"index" : @(model.index), @"count" : @(model.count), @"score" : @(model.score)};
        [arrM addObject:dic];
    }
    
    [arrM writeToFile:fileDataPath atomically:YES];
    NSLog(@"fileDataPath--%@", fileDataPath);
    
    [self.tableV reloadData];
}

- (void)dealloc {
    
    NSLog(@"dealloc---%s", __func__);
}
@end
