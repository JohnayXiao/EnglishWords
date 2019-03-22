//
//  PlayVC.h
//  知识
//
//  Created by Johnay  on 2018/2/8.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainModel.h"
@interface PlayVC : BaseViewController

- (instancetype)initWithModel:(mainModel *)model;

@property(nonatomic, strong)mainModel *model;

@property(nonatomic, copy) void (^refreshBlock) ();

@end
