//
//  TimeTool.h
//  tech2real
//
//  Created by HappenMacMini on 2017/3/10.
//  Copyright © 2017年 SZUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject

+ (NSString *)getNewsColumnCellTimeStringWithTImestamp:(NSString *)createDate;

+ (NSString *)getTimeStringWithTimestamp:(NSString *)createDate;

+ (NSString *)getTimeWithFullStyle:(NSString *)timestamp;

+ (NSString *)getYMDStyle:(NSString *)timestamp;

+ (NSString *)getYMDHMStyle:(NSString *)timestamp;

+ (NSString *)getMDStyle:(NSString *)timestamp;



//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestamp3;

@end
