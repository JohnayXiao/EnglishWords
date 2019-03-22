//
//  UIView+Extend.h
//
//  Created by ajsong on 15/10/9.
//  Copyright (c) 2015 ajsong. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - UIView+GlobalExtend
typedef enum : NSInteger {
    UIPanGestureRecognizerDirectionUndefined = 0,
    UIPanGestureRecognizerDirectionUp,
    UIPanGestureRecognizerDirectionDown,
    UIPanGestureRecognizerDirectionLeft,
    UIPanGestureRecognizerDirectionRight,
} UIPanGestureRecognizerDirection;
typedef enum : NSInteger {
    GeLineTypeTop = 0,
    GeLineTypeBottom,
    GeLineTypeLeft,
    GeLineTypeRight,
    GeLineTypeUpBottom,
    GeLineTypeLeftRight,
    GeLineTypeAll,
} GeLineType;
@interface UIView (GlobalExtend)<UIGestureRecognizerDelegate>
- (NSMutableDictionary*)element;
- (void)removeElement:(NSString*)key;
- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)left;
- (CGFloat)top;
- (CGFloat)right;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGPoint)origin;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGSize)size;
- (CGFloat)getLeftUntil:(UIView*)view;
- (CGFloat)getTopUntil:(UIView*)view;
- (CGFloat)getWidthPercent:(CGFloat)percent;
- (CGFloat)getHeightPercent:(CGFloat)percent;
- (CGPoint)offset;
- (void)setLeft:(CGFloat)newLeft;
- (void)setTop:(CGFloat)newTop;
- (void)setRight:(CGFloat)newRight;
- (void)setBottom:(CGFloat)newBottom;
- (void)setX:(CGFloat)x;
-(void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)newWidth;
- (void)setHeight:(CGFloat)newHeight;
- (void)setOrigin:(CGPoint)newOrigin;
- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;
- (void)setSize:(CGSize)newSize;
- (void)setBlockColor;
- (void)shadowColorRound;
- (void)shadowColorRectan;
- (void)setWidthPercent:(CGFloat)newWidth;
- (void)setHeightPercent:(CGFloat)newHeight;
- (UIColor*)shadow;
- (void)setShadow:(UIColor*)color;
- (NSInteger)index;
- (UIView*)subviewAtIndex:(NSInteger)index;
- (UIView*)firstSubview;
- (UIView*)lastSubview;
- (UIView*)prevView;
- (UIView*)prevView:(NSInteger)count;
- (NSMutableArray*)prevViews;
- (UIView*)nextView;
- (UIView*)nextView:(NSInteger)count;
- (NSMutableArray*)nextViews;
- (NSArray*)allSubviews;
- (NSArray*)subviewsOfTag:(NSInteger)tag;
- (NSArray*)subviewsOfClass:(Class)cls;
//- (UIView *)isOfClass:(Class)cls and:(Class)cls2;
- (UIView*)parentOfClass:(Class)cls;
- (UIViewController*)parentViewController;
- (BOOL)includeSubview:(UIView*)subview;
- (BOOL)includeSubviewOfClass:(Class)cls;
- (void)aboveToView:(UIView*)view;
- (void)belowToView:(UIView*)view;
- (UIView*)cloneView;
- (NSArray*)backgroundColors;
- (void)setBackgroundColors:(NSArray*)backgroundColors;
- (void)setBackgroundImage:(UIImage*)backgroundImage;
- (void)opacityIn:(NSTimeInterval)duration completion:(void (^)())completion;
- (void)opacityOut:(NSTimeInterval)duration completion:(void (^)())completion;
- (void)opacityTo:(NSInteger)opacity duration:(NSTimeInterval)duration completion:(void (^)())completion;
- (void)opacityFn:(NSTimeInterval)duration afterHidden:(void (^)())afterHidden completion:(void (^)())completion;
- (void)fadeIn:(NSTimeInterval)duration completion:(void (^)())completion;
- (void)fadeOut:(NSTimeInterval)duration completion:(void (^)())completion;
- (void)removeOut:(NSTimeInterval)duration completion:(void (^)())completion;
- (void)scaleViewWithPercent:(CGFloat)percent andpercent:(CGFloat)percent2;
- (void)scaleAnimateWithTime:(NSTimeInterval)time percent:(CGFloat)percent completion:(void (^)())completion;
- (void)scaleAnimateBouncesWithTime:(NSTimeInterval)time percent:(CGFloat)percent completion:(void (^)())completion;
- (void)scaleAnimateBouncesWithTime:(NSTimeInterval)time percent:(CGFloat)percent bounce:(CGFloat)bounce completion:(void (^)())completion;
- (void)rotatedViewWithDegrees:(CGFloat)degrees;
- (void)rotatedViewWithDegrees:(CGFloat)degrees center:(CGPoint)center;
- (void)addBlodColore;
- (void)setRectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius;
- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)action;
- (void)addTapGestureRecognizerWithTouches:(NSInteger)touches target:(id)target action:(SEL)action;
- (void)addLongPressGestureRecognizerWithTarget:(id)target action:(SEL)action;
- (void)addLongPressGestureRecognizerWithTouches:(NSInteger)touches target:(id)target action:(SEL)action;
- (void)addSwipeGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection)direction target:(id)target action:(SEL)action;
- (void)addSwipeGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection)direction touches:(NSInteger)touches target:(id)target action:(SEL)action;
- (void)addPanGestureRecognizerWithCompletion:(void (^)(NSMutableDictionary * direction))completion endOK:(void (^)(NSMutableDictionary * directionOK))end;
- (void)click:(void(^)(UIView *view))block;
- (void)longClick:(void(^)(UIView *view))block;
- (void)blur;
- (void)Unblur;
@end

//#pragma mark - UIWindow+GlobalExtend
//@interface UIWindow (GlobalExtend)
//- (UIViewController*)currentController;
//@end
