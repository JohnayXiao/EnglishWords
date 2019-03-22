//
//  PlayModel.h
//  知识
//
//  Created by Johnay  on 2018/2/8.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayModel : NSObject

@property (nonatomic, strong) NSString *question;

@property (nonatomic, strong) NSString *answer;

@property (nonatomic, strong) NSString *status;

+ (instancetype)playModelWithDic:(NSDictionary *)dic;

@end
