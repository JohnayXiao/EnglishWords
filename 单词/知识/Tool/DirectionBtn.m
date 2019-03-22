//
//  DirectionBtn.m
//  知识
//
//  Created by Johnay  on 2018/2/7.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "DirectionBtn.h"

@implementation DirectionBtn

- (instancetype)init {
    
    if (self = [super init]) {
        
//        self.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.66];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = FitValue(5);
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = FitValue(0);
    self.imageView.y = 0;
    self.imageView.width = self.height;
    self.imageView.height = self.imageView.width;
    
   
}

@end
