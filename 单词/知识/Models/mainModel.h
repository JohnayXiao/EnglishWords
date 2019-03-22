//
//  mainModel.h
//  知识
//
//  Created by Johnay  on 2018/2/11.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mainModel : NSObject

@property(nonatomic, retain)NSString *plistName;
@property(nonatomic, retain)NSString *imgUrl;
@property(nonatomic, retain)NSString *title;
@property(nonatomic, retain)NSString *brief;
@property(nonatomic, retain)NSString *time;
//@property(nonatomic, retain)NSString *isVip;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) CGFloat score;


//@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)mainModelWithDic:(NSDictionary *)dic;

@end
