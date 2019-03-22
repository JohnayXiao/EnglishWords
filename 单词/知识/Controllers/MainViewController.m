//
//  MainViewController.m
//  知识
//
//  Created by Johnay  on 2018/2/11.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "MainViewController.h"
#import "mainCell.h"
#import "UINavigationBar+Awesome.h"
#import "ThemeViewController.h"
#import "TimeTool.h"
#import <StoreKit/StoreKit.h>

static NSString *const reuseIdentifier = @"XJMainCell";

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    NSString *fileDataPath;
}

@property (nonatomic, assign) BOOL isCanSideBack;
@property (nonatomic, strong) UIImageView *backImgV;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MainViewController


- (NSMutableArray *)dataSource {
    
    if (_dataSource == nil) {
        
        _dataSource = @[].mutableCopy;
        
        // 加载plist文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mainPlist" ofType:@"plist"];
        
        NSMutableArray *fileArr = [NSMutableArray arrayWithContentsOfFile:filePath];
        
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        fileDataPath = [docPath stringByAppendingPathComponent:@"mainPlistData.plist"];
        //如果文件存在，将操作数据合并
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileDataPath]) {
            
            // 加载plist文件
            NSArray *arr = [NSArray arrayWithContentsOfFile:fileDataPath];
            
            for (NSDictionary *dic in arr) {
                
                for (NSDictionary *dic2 in fileArr) {
                    
                    if ([dic[@"plistName"] isEqualToString:dic2[@"plistName"]]) {
                        
                        [dic2 setValue:dic[@"time"] forKey:@"time"];
                        
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
        NSLog(@"%@", _dataSource);
    }
    
    
    return _dataSource;
}

- (void)saveSortedPlist {
    
    
    _dataSource = [[_dataSource sortedArrayUsingComparator:^NSComparisonResult(mainModel *model1, mainModel *model2) {
        
        return [model2.time compare:model1.time]; //倒序
        
    }] mutableCopy];
    
    NSMutableArray *arrM = @[].mutableCopy;
    
    for (mainModel *model in self.dataSource) {
        
        NSDictionary *dic = @{@"plistName" : model.plistName, @"time" : model.time};
        [arrM addObject:dic];
    }
    
    [arrM writeToFile:fileDataPath atomically:YES];
    NSLog(@"fileDataPath--%@", fileDataPath);
    
    [self.tableV reloadData];
}

//MARK: - 入口
- (void)viewDidLoad {
    [super viewDidLoad];
//

    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"screen2"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setValue:fangSongWithSize(20) forKey:NSFontAttributeName];
    [attributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationItem.title = @"You Must Learn English Well !";
//    self.navigationController.navigationBarHidden = YES;
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XJ_ScreenWidth, XJ_ScreenHeight - XJ_safeBottomMargin - XJ_NavigationBarHeight)];
    self.tableV.backgroundColor = grayBgColor;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.bounces = NO;
    self.tableV.separatorStyle = 0;
    self.tableV.estimatedRowHeight = 300.0;
//    adjustsScrollViewInsetNever(self, self.tableV);
    [self.tableV registerClass:[mainCell class] forCellReuseIdentifier:reuseIdentifier];
    
    UILabel *footV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XJ_ScreenWidth, FitValue(20))];
    footV.text = @"^_^The End^_^";
    footV.textColor = grayTextColor;
    footV.font = regularFontWithSize(10);
    footV.textAlignment = NSTextAlignmentCenter;
    self.tableV.tableFooterView = footV;
    
    [self.view addSubview:self.tableV];

    
    //假设控件初始状态为状态1.
    
    [UIView animateWithDuration:2.0f animations:^{
        
        [self.view setTransform:CGAffineTransformMakeRotation(M_PI)];
        
        //rotation后面跟的是控件旋转的最终位置，当前为顺时针180度位置。目前为状态2.
        
        [self.view setTransform:CGAffineTransformMakeRotation(0)];
        
        //这段代码使控件旋转到离初始状态（即状态1）0度旋转量的位置，也就是归位操作。
        
        //这里有个有趣的现象：归位时控件仍然是顺时针旋转，为了达到逆时针旋转归位的效果调整代码如下：
        
//        [self.view setTransform:CGAffineTransformMakeRotation(M_PI*0.0000001)];
        
    }];
    
    
}

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

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 300.0;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    mainModel *model = self.dataSource[indexPath.row];
    
    mainCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.model = model;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    mainModel *model = self.dataSource[indexPath.row];
    
    ThemeViewController *vc = [[ThemeViewController alloc] initWithTitle:model.title andPlistName:model.plistName];
   
    [self.navigationController pushViewController:vc animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        model.time = [TimeTool getNowTimeTimestamp3];
        [self saveSortedPlist];
    });
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.isCanSideBack = NO; //关闭ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
        
    }
    
}
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    self.isCanSideBack=YES; //开启ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        
    }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer
{
    return self.isCanSideBack;
    
}


@end
