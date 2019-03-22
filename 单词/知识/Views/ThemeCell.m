//
//  ThemeCell.m
//  知识
//
//  Created by Johnay  on 2018/2/14.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "ThemeCell.h"
#import "TimeTool.h"
static CGFloat const padding = 10.f;

@interface ThemeCell()

@property (nonatomic , strong) UILabel *titleLB;
@property (nonatomic, strong)  UILabel *contentLB;
@property (nonatomic, strong) UILabel *subLB;
@property (nonatomic, strong) UILabel *recommendLB;
@property (nonatomic , strong) UIImageView *topImgv;
@property (nonatomic, strong) UIView *topEmptyV;
@property (nonatomic, strong) UIView *bottomEmptyV;

@end

@implementation ThemeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化里面的控件
        
        self.topEmptyV = [[UIView alloc] init];
        self.topEmptyV.backgroundColor = grayBgColor;
        [self.contentView addSubview:self.topEmptyV];
        
        
        self.topImgv = [[UIImageView alloc] init];
        self.topImgv.clipsToBounds = YES;
        self.topImgv.contentMode = UIViewContentModeScaleToFill;
        self.topImgv.backgroundColor = RGBCOLOR(81, 81, 81);
        [self.contentView addSubview:self.topImgv];
        
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = [UIFont systemFontOfSize:15];
        self.titleLB.numberOfLines = 2;
        self.titleLB.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLB.textColor = [UIColor colorWithRed:93/255 green:101/255 blue:115/255 alpha:1];
        self.titleLB.preferredMaxLayoutWidth = XJ_ScreenWidth - 2 * padding;
        [self.contentView addSubview:self.titleLB];
        
        self.contentLB = [[UILabel alloc] init];
        self.contentLB.font = [UIFont systemFontOfSize:12];
        self.contentLB.numberOfLines = 0;
        self.contentLB.textColor = grayTextColor;
        self.contentLB.preferredMaxLayoutWidth = XJ_ScreenWidth - 2 * padding;
        [self.contentView addSubview:self.contentLB];
        
        self.subLB = [[UILabel alloc] init];
        self.subLB.font = [UIFont systemFontOfSize:12];
        self.subLB.textColor = grayTextColor;
        [self.contentView addSubview:self.subLB];
        
        
        self.recommendLB = [[UILabel alloc] init];
        self.recommendLB.font = [UIFont systemFontOfSize:10];
        self.recommendLB.textAlignment = NSTextAlignmentCenter;
        self.recommendLB.textColor = [UIColor whiteColor];
        self.recommendLB.layer.cornerRadius = 8;
        self.recommendLB.layer.masksToBounds = YES;
        [self.contentView addSubview:self.recommendLB];
        
        self.backgroundColor = [UIColor whiteColor];
        [self configLayout];
    }
    return self;
}

- (void)configLayout {
    
    // 设置控件的方位
    WeakSelf
    
    [self.topEmptyV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(weakSelf.contentView);
        make.height.equalTo(@10);
    }];
    
    [self.topImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.topEmptyV.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.contentView).offset(padding);
        make.right.equalTo(weakSelf.contentView).offset(-padding);
        make.height.equalTo(@(FitValue(180)));
        
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.topImgv.mas_bottom).offset(10);
        make.left.right.equalTo(weakSelf.topImgv);
        
    }];
    
    
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(6);
        make.left.right.equalTo(weakSelf.titleLB);
        
    }];
    
    [self.subLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentLB.mas_bottom).offset(6);
        make.left.equalTo(weakSelf.contentLB);
        make.height.equalTo(@15);
    }];
    
    [self.recommendLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.subLB);
        make.right.bottom.equalTo(weakSelf.contentView).offset(-padding);
        make.width.equalTo(@45);
        make.height.equalTo(@16);
    }];
    
    //    [self.bottomEmptyV mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(weakSelf.subLB.mas_bottom).offset(padding);
    //        make.left.right.bottom.equalTo(weakSelf.contentView);
    //        make.height.equalTo(@10);
    //    }];
    
    
    
    
}


- (void)setModel:(mainModel *)model {
    
    _model = model;
    
    self.topImgv.image = [UIImage imageNamed:model.imgUrl];
    self.titleLB.text = model.title;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.brief attributes:nil];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//行间距
    
    //    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.brief.length)];
    
    [self.contentLB setAttributedText:attributedString];
    
    if ([model.time isEqualToString:@"0"]) {
        
        self.recommendLB.text = @"未开始";
        
        self.subLB.text = [NSString stringWithFormat:@"%ld/%ld", model.index + 1, model.count];
        
        self.recommendLB.backgroundColor = RGBCOLOR(156, 212, 249);
        
    }else {
        
        self.subLB.text = [NSString stringWithFormat:@"%ld/%ld  %@", model.index + 1, model.count, [TimeTool getTimeStringWithTimestamp:model.time]];
        self.recommendLB.text = [self getDegree];
        
        if (_model.score + 0.01 < 60) {
            
            self.recommendLB.backgroundColor = RGBCOLOR(250, 126, 0);
            
        }else if (_model.score + 0.01 < 90) {
            
            self.recommendLB.backgroundColor = RGBCOLOR(132, 240, 100);
            
        } else {
            
            self.recommendLB.backgroundColor = RGBCOLOR(240, 62, 56);
        }
    }
    
    
//    [self layoutIfNeeded];
//
//    _model.cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 10;
    
}

- (NSString *)getDegree {
    
    if (_model.score + 0.01 < 10) {
        
        return @"学前班";
        
    }else if(_model.score + 0.01 < 20) {
        
        return @"幼儿园";
        
    }else if(_model.score + 0.01 < 30) {
        
        return @"小学";
        
    }else if(_model.score + 0.01 < 40) {
        
        return @"初中";
        
    }else if(_model.score + 0.01 < 50) {
        
        return @"高中";
        
    }else if(_model.score + 0.01 < 60) {
        
        return @"专科";
        
    }else if(_model.score + 0.01 < 70) {
        
        return @"本科";
        
    }else if(_model.score + 0.01 < 80) {
        
        return @"硕士";
        
    }else if(_model.score + 0.01 < 90) {
        
        return @"博士";
        
    }else if(_model.score + 0.01 < 100) {
        
        return @"博士后";
        
    }else {
        
        return @"国之栋梁";
    }
}

@end
