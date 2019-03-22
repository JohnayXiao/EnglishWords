//
//  mainCell.m
//  tech2real
//
//  Created by Johnay  on 17/12/12.
//  Copyright © 2017年 SZUI. All rights reserved.
//

#import "mainCell.h"
static CGFloat const padding = 10.f;

@interface mainCell()
@property (nonatomic , strong) UILabel *titleLB;
@property (nonatomic, strong)  UILabel *contentLB;
@property (nonatomic , strong) UIImageView *topImgv;
@property (nonatomic, strong) UIView *topEmptyV;
@end

@implementation mainCell

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
//        make.height.equalTo(weakSelf.contentView.mas_width).multipliedBy(0.618);
        make.height.equalTo(@(XJ_ScreenWidth * 0.61));
        
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.topImgv.mas_bottom).offset(10);
        make.left.right.equalTo(weakSelf.topImgv);
        
    }];
    

    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(6);
        make.left.right.equalTo(weakSelf.titleLB);
        make.bottom.equalTo(weakSelf.contentView).offset(-padding);

    }];
    
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
    
//    [self layoutIfNeeded];

//    _model.cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 10;

}

@end
