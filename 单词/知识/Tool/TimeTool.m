//
//  TimeTool.m
//  tech2real
//
//  Created by HappenMacMini on 2017/3/10.
//  Copyright © 2017年 SZUI. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

#pragma mark - 获取资讯栏目cell的时间

+(NSString *)getNewsColumnCellTimeStringWithTImestamp:(NSString *)createDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:createDate];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    
    NSString *dateContent;
    if (days > 24) {
        NSRange range = NSMakeRange(5, 5);
        dateContent = [NSString stringWithFormat:@"%@", [createDate substringWithRange:range]];
        
        
    } else if (days != 0){
        NSRange range = NSMakeRange(5, 5);
        dateContent = [NSString stringWithFormat:@"%@", [createDate substringWithRange:range]];
        
        //dateContent = [NSString stringWithFormat:@"%@",]
    } else if ( hours != 0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",hours,@"小时前"];
        
    } else if (minute >= 1){
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,@"分钟前"];
        
    } else if (minute < 1){
        
        dateContent = @"刚刚";
    }
    return dateContent;

}

#pragma mark - 获取资讯评论的时间
+(NSString *)getTimeStringWithTimestamp:(NSString *)createDate
{
    long long int createTime = [createDate longLongValue];
    long long int secTime = createTime / 1000;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeInterval timeInterval = secTime;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateStr = [formatter stringFromDate:date2];
    NSString *temp = [self getUTCFormateDate:dateStr];
    
    if ([[temp substringWithRange:NSMakeRange(0, 1)] isEqualToString:@" "] ) {
        NSString *temp3 = [temp substringFromIndex:3];
        NSLog(@"time -> %@",temp3);
        return temp3;
    }else{
        NSLog(@"time -> %@",temp);
        return temp;
    }

}

+ (NSString *)getUTCFormateDate:(NSString *)newsDate
{
    //    newsDate = @"2013-08-09 17:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time = [current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month=((int)time)/(3600*24*30);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    // NSLog(@"time=%ld",(double)time);
    
    
    NSString *dateContent;
    if(month!=0){
        
        NSRange range = NSMakeRange(5, 5);
        dateContent = [NSString stringWithFormat:@"%@",[newsDate substringWithRange:range]];
        
        
    }else if(days>10){
        
        NSRange range = NSMakeRange(5, 5);
        
        dateContent = [NSString stringWithFormat:@"%@",[newsDate substringWithRange:range]];
        
    }else if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ", days,@"天前"];
        
    }else if(hours!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",hours,@"小时前"];
        
    }else if(minute >= 1) {
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,@"分钟前"];
        
    }else if (minute < 1){
        
        dateContent = @"刚刚";
        
    }
    return dateContent;
}

+ (NSString *)getTimeWithFullStyle:(NSString *)timestamp
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)getYMDStyle:(NSString *)timestamp
{
    NSTimeInterval time=[timestamp doubleValue]/1000.0 ;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSString *)getYMDHMStyle:(NSString *)timestamp
{
    NSTimeInterval time=[timestamp doubleValue]/1000.0 ;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSString *)getMDStyle:(NSString *)timestamp
{
    NSTimeInterval time=[timestamp doubleValue]/1000.0 ;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//获取当前时间戳  （以毫秒为单位）

+(NSString *)getNowTimeTimestamp3{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}

@end
