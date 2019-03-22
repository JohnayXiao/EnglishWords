//
//  SelectBtn.m
//  知识
//
//  Created by Johnay  on 2018/2/7.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "SelectBtn.h"

@implementation SelectBtn

- (instancetype)init {
    
    if (self = [super init]) {
        
        
//        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.11];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = FitValue(5);
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        [self setImage:[UIImage imageNamed:@"infoWhite"] forState:UIControlStateNormal];
        [self setTitleColor:NormalColor forState:UIControlStateNormal];
        
        [self setImage:[UIImage imageNamed:@"questionWhite"] forState:UIControlStateHighlighted];
//        [self setTitleColor:HighlightColor forState:UIControlStateHighlighted];
        
//        [self setTitleColor:NormalColor forState:UIControlStateNormal | UIControlStateHighlighted];
        
        [self setImage:[UIImage imageNamed:@"fault"] forState:UIControlStateDisabled];
        [self setTitleColor:FaultColor forState:UIControlStateDisabled];
        
        [self setBackgroundImage:[UIImage imageNamed:@"btnBack3"] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:@"btnBack2"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"checkWhite"] forState:UIControlStateSelected];
//        [self setTitleColor:HighlightColor forState:UIControlStateSelected];
        
        [self setImage:[UIImage imageNamed:@"checkWhite"] forState:UIControlStateSelected | UIControlStateHighlighted];
//        [self setTitleColor:HighlightColor forState:UIControlStateSelected | UIControlStateHighlighted];
        
        
        [self.titleLabel setFont:regularFontWithSize(15)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //经过多次测试，只有10.0以上版本才能修改Frame
//    if(kDevice_System >= 10.0) {
//
//        NSString *content = self.titleLabel.text;
//        UIFont *font = self.titleLabel.font;
//        CGSize size = CGSizeMake(MAXFLOAT, self.height);
//        CGSize buttonSize = [content boundingRectWithSize:size
//                                                  options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                               attributes:@{ NSFontAttributeName:font}
//                                                  context:nil].size;
//
//        self.width = buttonSize.width + FitValue(70);
//
//    }

    // 调整图片
    self.imageView.x = FitValue(5);
    self.imageView.y = FitValue(10);
    self.imageView.width = FitValue(20);
    self.imageView.height = self.imageView.width;

    // 调整文字
    self.titleLabel.x = self.imageView.width + FitValue(15);
    self.titleLabel.y = 0;
    self.titleLabel.width = self.width - self.imageView.width - FitValue(10);
    self.titleLabel.height = self.height;
    
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    
    [super setTitle:title forState:state];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        UIFont *font = self.titleLabel.font;
        CGSize size = CGSizeMake(MAXFLOAT, self.height);
        CGSize buttonSize = [title boundingRectWithSize:size
                                                  options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{ NSFontAttributeName:font}
                                                  context:nil].size;
        
        make.width.equalTo(@(buttonSize.width + FitValue(60)));
    }];
}
@end
