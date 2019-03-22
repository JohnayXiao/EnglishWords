//
//  BaseViewController.h
//  知识
//
//  Created by Johnay  on 2018/2/7.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectBtn.h"
#import "DirectionBtn.h"
#import "VerticalButton.h"


@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIImageView *backImgV;

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *voiceBtn;

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) SelectBtn *selectBtn1;
@property (nonatomic, strong) SelectBtn *selectBtn2;
@property (nonatomic, strong) SelectBtn *selectBtn3;
@property (nonatomic, strong) SelectBtn *selectBtn4;

@property (nonatomic, strong) UIView *toolBoard;

@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) DirectionBtn *previousBtn;
@property (nonatomic, strong) VerticalButton *clearBtn;
@property (nonatomic, strong) DirectionBtn *nextBtn;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@end
