//
//  XJSuspendButton.m
//  核价宝
//
//  Created by Johnay  on 17/6/23.
//  Copyright © 2017年 com.sfdhb. All rights reserved.
//

#import "XJSuspendButton.h"

@interface XJSuspendButton()

/**  是否有导航栏*/
@property (nonatomic, assign) BOOL isThereNavBar;

/** 是否有TabBar*/
@property (nonatomic, assign) BOOL isThereTabBar;

/** 是否限制位置只能靠在左边或右边*/
@property (nonatomic, assign) BOOL positionBool;

@end
@implementation XJSuspendButton

- (instancetype)initWithFrame:(CGRect)frame isThereNavBar:(BOOL)navBool isThereTabBar:(BOOL)tabBool isLeftOrRight:(BOOL)positionBool{
    
    if (self = [super initWithFrame:frame]) {
        
        if (arc4random_uniform(2)) {
            
            [self setBackgroundColor:[UIColor orangeColor]];
            
        }else if (arc4random_uniform(2)) {
            
            [self setBackgroundColor:RGBCOLOR(250, 90, 79)];
            
        }else if (arc4random_uniform(2)) {
            
            [self setBackgroundColor:RGBCOLOR(106, 181, 114)];
            
        }else if (arc4random_uniform(2)) {
            
            [self setBackgroundColor:RGBCOLOR(137, 37, 140)];
            
        }else {
            
            [self setBackgroundColor:RGBCOLOR(74, 89, 172)];
        }
        
        [self setTitle:@"Touch me" forState:UIControlStateNormal];
        
        self.layer.cornerRadius = self.width <= self.height ? self.width / 2 : self.height / 2;
        
        self.layer.masksToBounds = YES;
        
        self.titleLabel.font = [UIFont systemFontOfSize:FitValue(14)];
        
        self.alpha = 0.7;
        
        _isThereNavBar = navBool;
        
        _isThereTabBar = tabBool;
        
        _positionBool = positionBool;
        
        
    }
    
    
    return self;
}

+ (instancetype)suspendButtonWithFrame:(CGRect)frame isThereNavBar:(BOOL)navBool isThereTabBar:(BOOL)tabBool isLeftOrRight:(BOOL)positionBool {
    
    return [[self alloc] initWithFrame:frame isThereNavBar:navBool isThereTabBar:tabBool isLeftOrRight:positionBool];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.alpha = 1.0;
    [self setTitle:@"Move me" forState:UIControlStateNormal];
    
    if (arc4random_uniform(2)) {
        
        [self setBackgroundColor:[UIColor orangeColor]];
        
    }else if (arc4random_uniform(2)) {
        
        [self setBackgroundColor:RGBCOLOR(250, 90, 79)];
        
    }else if (arc4random_uniform(2)) {
        
        [self setBackgroundColor:RGBCOLOR(106, 181, 114)];
        
    }else if (arc4random_uniform(2)) {
        
        [self setBackgroundColor:RGBCOLOR(137, 37, 140)];
        
    }else {
        
        [self setBackgroundColor:RGBCOLOR(74, 89, 172)];
    }
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:self];
    
    CGPoint previousPoint = [touch previousLocationInView:self];
    
    CGFloat offsetX = currentPoint.x - previousPoint.x;
    
    CGFloat offsetY = currentPoint.y - previousPoint.y;
    
    CGPoint origin = self.origin;
    
    origin.x += offsetX;
    
    origin.y += offsetY;
        
    if (origin.x < 0) {//左边
        
        origin.x = 0;
    }
    
    if (origin.y < 0) {//上边
        
        origin.y = 0;
    }
    
    if (origin.x > XJ_ScreenWidth - self.width) {//右边
        
        origin.x = XJ_ScreenWidth - self.width;
    }
    
    
    CGFloat bottom = XJ_ScreenHeight - self.height - (_isThereNavBar ? XJ_NavigationBarHeight : 0) -  (_isThereTabBar ? XJ_TabbarHeight : XJ_safeBottomMargin);
    
    if (origin.y > bottom) {//下边
        
        origin.y = bottom;
    }
    
    self.origin = origin;

//    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    CGPoint origin = self.origin;
   
    if (_positionBool) {
        
        if (origin.x > (XJ_ScreenWidth - self.width) / 2) {
            
            origin.x = XJ_ScreenWidth - self.width;
            
        }else {
            
            origin.x = 0;
        }
    }
    
    self.origin = origin;
    
    [[NSUserDefaults standardUserDefaults] setFloat:origin.x forKey:@"xjSuspendButtonX"];
    [[NSUserDefaults standardUserDefaults] setFloat:origin.y forKey:@"xjSuspendButtonY"];
    
    self.alpha = 0.7;
    
    [self setTitle:@"Touch me" forState:UIControlStateNormal];
}


@end
