//
//  XJSuspendButton.h
//  核价宝
//
//  Created by Johnay  on 17/6/23.
//  Copyright © 2017年 com.sfdhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJSuspendButton : UIButton
/**
 * 创建一个XJSuspendButton
 * isThereNavBar 是否存在Navigation Bar
 * isThereNavBar 是否存在TabBar
 *isLeftOrRight 是否限制位置只能靠着两侧
 */- (instancetype)initWithFrame:(CGRect)frame isThereNavBar:(BOOL)navBool isThereTabBar:(BOOL)tabBool isLeftOrRight:(BOOL)positionBool;

/** 
  * 创建一个XJSuspendButton
  * isThereNavBar 是否存在Navigation Bar
  * isThereNavBar 是否存在TabBar
  * isLeftOrRight 是否限制位置只能靠着两侧
  */
+ (instancetype)suspendButtonWithFrame:(CGRect)frame isThereNavBar:(BOOL)navBool isThereTabBar:(BOOL)tabBool isLeftOrRight:(BOOL)positionBool;

@end
