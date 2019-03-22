//
//  BaseViewController.m
//  知识
//
//  Created by Johnay  on 2018/2/7.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.backImgV];
    
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    WeakSelf
    [_backBtn click:^(UIView *view) {

        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [weakSelf.navigationController.view.layer addAnimation:animation forKey:@"animation"];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [_backBtn setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview:_backBtn];
    
    _toolBoard = [[UIView alloc] init];
    [self.view addSubview:_toolBoard];
    
    
    _topLabel = [[UILabel alloc] init];
    _topLabel.text = @"11/190";
    _topLabel.font = regularFontWithSize(18);
    _topLabel.textAlignment = NSTextAlignmentCenter;
    [_toolBoard addSubview:_topLabel];
    
    _previousBtn = [[DirectionBtn alloc] init];
    [_previousBtn setImage:[UIImage imageNamed:@"previousWhite"] forState:0];
    [_toolBoard addSubview:_previousBtn];
    
    _clearBtn = [[VerticalButton alloc] init];
    [_clearBtn setImage:[UIImage imageNamed:@"stopWhite"] forState:0];
    [_clearBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_clearBtn setTitleColor:DisableColor forState:1];
    [_clearBtn setTitleColor:DisableColor forState:2];
    [_clearBtn.titleLabel setFont:regularFontWithSize(10)];
    [_toolBoard addSubview:_clearBtn];
    
    _nextBtn = [[DirectionBtn alloc] init];
    [_nextBtn setImage:[UIImage imageNamed:@"nextWhite"] forState:0];
    [_toolBoard addSubview:_nextBtn];
    
    
    _bottomLabel = [[UILabel alloc] init];
    _bottomLabel.text = @"11/190";
    _bottomLabel.font = regularFontWithSize(18);
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    [_toolBoard addSubview:_bottomLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = fangSongWithSize(20);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_titleLabel];
    
    _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_voiceBtn];
    
    
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = regularFontWithSize(18);
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_numberLabel];
    
    _questionLabel = [[UILabel alloc] init];
    _questionLabel.preferredMaxLayoutWidth = XJ_ScreenWidth - FitValue(40);
    _questionLabel.numberOfLines = 0;    
    _questionLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_questionLabel];
    
    _selectBtn1 = [[SelectBtn alloc] init];
    [self.view addSubview:_selectBtn1];
    
    _selectBtn2 = [[SelectBtn alloc] init];
    [self.view addSubview:_selectBtn2];
    
    _selectBtn3 = [[SelectBtn alloc] init];
    [self.view addSubview:_selectBtn3];
    
    _selectBtn4 = [[SelectBtn alloc] init];
    [self.view addSubview:_selectBtn4];
    
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(5);
        make.top.equalTo(self.view).offset(XJ_StatusBarHeight);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_backBtn.mas_right);
        make.top.height.equalTo(_backBtn);
        make.width.equalTo(@(XJ_ScreenWidth - 93));
    }];
    
    [_voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view).offset(FitValue(0));
        make.top.width.height.equalTo(_backBtn);
    }];
    
    
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).offset(FitValue(3));
        make.left.equalTo(self.view).offset(FitValue(10));
        make.width.lessThanOrEqualTo(@(FitValue(45)));
    }];
    
    [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(_numberLabel.mas_right);
        make.right.equalTo(self.view).offset(-FitValue(10));
    }];
    
    CGFloat btnHeight = FitValue(40);
    
    [_selectBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(FitValue(20));
        make.height.equalTo(@(btnHeight));
        make.top.equalTo(_questionLabel.mas_bottom).offset(FitValue(20));
        
        
    }];
    
    [_selectBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(FitValue(20));
        make.height.equalTo(@(btnHeight));
        make.top.equalTo(_selectBtn1.mas_bottom).offset(FitValue(20));
        
    }];
    
    [_selectBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(FitValue(20));
        make.height.equalTo(@(btnHeight));
        make.top.equalTo(_selectBtn2.mas_bottom).offset(FitValue(20));
        
    }];
    
    [_selectBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(FitValue(20));
        make.height.equalTo(@(btnHeight));
        make.top.equalTo(_selectBtn3.mas_bottom).offset(FitValue(20));
        
    }];
    
    
    //工具盘
    
    CGFloat toolBoardHeight = FitValue(300);
    
    [_toolBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(toolBoardHeight));
        make.height.equalTo(@(FitValue(180)));
        make.bottom.equalTo(self.view).offset(-20);

    }];
    
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_toolBoard);
        make.bottom.equalTo(_clearBtn.mas_top).offset(-FitValue(20));
        
    }];
    
    [_previousBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_toolBoard);
        make.width.height.equalTo(@(FitValue(40)));
        make.centerY.equalTo(_toolBoard).offset(FitValue(2));
        
    }];
    
    [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(FitValue(60)));
        make.width.equalTo(@(FitValue(40)));
        make.centerX.equalTo(_toolBoard);
        make.centerY.equalTo(_toolBoard).offset(FitValue(7));
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_toolBoard);
        make.width.height.equalTo(@(FitValue(40)));
        make.centerY.equalTo(_toolBoard);
        
    }];
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_toolBoard);
        make.top.equalTo(_clearBtn.mas_bottom).offset(FitValue(20));
        
    }];
    
}

@end
