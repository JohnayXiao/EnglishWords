//
//  mainModel.m
//  知识
//
//  Created by Johnay  on 2018/2/11.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "mainModel.h"

@implementation mainModel

+ (instancetype)mainModelWithDic:(NSDictionary *)dic {
    
    mainModel *p = [[self alloc] init];
    
    [p setValuesForKeysWithDictionary:dic];
    
    return p;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setNilValueForKey:(NSString *)key {
    
    
}
@end
