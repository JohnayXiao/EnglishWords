//
//  PlayModel.m
//  知识
//
//  Created by Johnay  on 2018/2/8.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "PlayModel.h"

@implementation PlayModel

+ (instancetype)playModelWithDic:(NSDictionary *)dic
{
    PlayModel *p = [[self alloc] init];
    
    [p setValuesForKeysWithDictionary:dic];
    
    return p;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setNilValueForKey:(NSString *)key {
    
    
}
@end
