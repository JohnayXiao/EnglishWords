//
//  UIView+Extend.m
//
//  Created by ajsong on 15/10/9.
//  Copyright (c) 2015 ajsong. All rights reserved.
//

//#if TARGET_IPHONE_SIMULATOR
//#import <objc/objc-runtime.h>
//#else
//#import <objc/runtime.h>
//#endif
#import <objc/runtime.h>

#pragma mark - NSObject+GlobalExtend
@implementation NSObject (GlobalExtend)
- (NSMutableDictionary*)element{
    NSMutableDictionary *ele = objc_getAssociatedObject(self, @"element");
    if (!ele) {
        ele = [[NSMutableDictionary alloc]init];
        objc_setAssociatedObject(self, @"element", ele, OBJC_ASSOCIATION_RETAIN);
    }
    return ele;
}
- (void)removeElement:(NSString*)key{
    NSMutableDictionary *ele = objc_getAssociatedObject(self, @"element");
    if (!ele) return;
    [ele removeObjectForKey:key];
    objc_setAssociatedObject(self, @"element", ele, OBJC_ASSOCIATION_RETAIN);
}
@end

#pragma mark - UIView+GlobalExtend
@implementation UIView (GlobalExtend)
- (NSMutableDictionary*)element{
    NSMutableDictionary *ele = objc_getAssociatedObject(self, @"element");
    if (!ele) {
        ele = [[NSMutableDictionary alloc]init];
        objc_setAssociatedObject(self, @"element", ele, OBJC_ASSOCIATION_RETAIN);
    }
    return ele;
}
- (void)removeElement:(NSString*)key{
    NSMutableDictionary *ele = objc_getAssociatedObject(self, @"element");
    if (!ele) return;
    [ele removeObjectForKey:key];
    objc_setAssociatedObject(self, @"element", ele, OBJC_ASSOCIATION_RETAIN);
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat)centerX{
    return self.center.x;
}
- (CGFloat)centerY{
    return self.center.y;
}
- (CGSize)size{
    return self.frame.size;
}

- (CGFloat)getLeftUntil:(UIView*)view{
    CGFloat left = self.frame.origin.x;
    UIView *superView = self.superview;
    while (![superView isEqual:view]) {
        left += superView.frame.origin.x;
        superView = superView.superview;
        if (superView==nil) break;
    }
    return left;
}

- (CGFloat)getTopUntil:(UIView*)view{
    CGFloat top = self.frame.origin.y;
    UIView *superView = self.superview;
    while (![superView isEqual:view]) {
        top += superView.frame.origin.y;
        superView = superView.superview;
        if (superView==nil) break;
    }
    return top;
}

- (CGFloat)getWidthPercent:(CGFloat)percent{
    return self.frame.size.width * (percent / 100);
}

- (CGFloat)getHeightPercent:(CGFloat)percent{
    return self.frame.size.height * (percent / 100);
}

- (CGPoint)offset{
    UIView *view = self;
    CGFloat x = 0;
    CGFloat y = 0;
    while (view) {
        if ([view.superview isKindOfClass:[UIScrollView class]]) {
            y -= ((UIScrollView*)view.superview).contentOffset.y;
        }
        x += view.frame.origin.x;
        y += view.frame.origin.y;
        view = view.superview;
    }
    return CGPointMake(x, y);
}

- (void)setLeft:(CGFloat)newLeft{
    CGRect frame = self.frame;
    frame.origin.x = newLeft;
    self.frame = frame;
}

- (void)setTop:(CGFloat)newTop{
    CGRect frame = self.frame;
    frame.origin.y = newTop;
    self.frame = frame;
}

- (void)setRight:(CGFloat)newRight{
    CGRect frame = self.frame;
    if (self.superview)
        frame.origin.x = self.superview.frame.size.width - frame.size.width - newRight;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)newBottom{
    CGRect frame = self.frame;
    if (self.superview) frame.origin.y = newBottom - frame.size.height;
    self.frame = frame;
}

-(void)setX:(CGFloat)x{
    CGRect r        = self.frame;
    r.origin.x      = x;
    self.frame      = r;
}

-(void)setY:(CGFloat)y{
    CGRect r        = self.frame;
    r.origin.y      = y;
    self.frame      = r;
}

- (void)setWidth:(CGFloat)newWidth{
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)newHeight{
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)newOrigin{
    CGRect frame = self.frame;
    frame.origin = newOrigin;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat)x{
    CGPoint point = CGPointMake(x, self.center.y);
    self.center = point;
}

- (void)setCenterY:(CGFloat)y{
    CGPoint point = CGPointMake(self.center.x,y);
    self.center = point;
}

- (void)setSize:(CGSize)newSize{
    CGRect frame = self.frame;
    frame.size = newSize;
    self.frame = frame;
}
- (void)setBlockColor{
    self.layer.shadowColor = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1].CGColor;
    //    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset=CGSizeMake(0,0);
    self.layer.shadowOpacity=1;
    self.layer.shadowRadius=2;
}

- (void)shadowColorRound{
    UIView * gg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width/2, self.height/2)];
    gg.center = CGPointMake(self.centerX, self.centerY);
    gg.backgroundColor = [UIColor whiteColor];
    //    gg.layer.shadowColor = viewShadow.CGColor;//shadowColor阴影颜色
    gg.layer.shadowOffset = CGSizeMake(0,20);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    gg.layer.shadowOpacity = 1;//阴影透明度，默认0
    gg.layer.shadowRadius = gg.width/2 -5;//阴影半径，默认3
    [self.superview insertSubview:gg belowSubview:self];
}

- (void)shadowColorRectan{
    UIView * uu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width-self.height/2, self.height/2)];
    uu.center = CGPointMake(self.centerX, self.centerY);
    uu.backgroundColor = [UIColor whiteColor];
    //    uu.layer.shadowColor = viewShadow.CGColor;//shadowColor阴影颜色
    uu.layer.shadowOffset = CGSizeMake(0,10);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    uu.layer.shadowOpacity = 1;//阴影透明度，默认0
    uu.layer.shadowRadius = uu.height/2;//阴影半径，默认3
    [self.superview insertSubview:uu belowSubview:self];
}

- (void)setWidthPercent:(CGFloat)newWidth{
    CGFloat width = 0;
    CGRect frame = self.frame;
    if (self.superview) width = self.superview.frame.size.width * (newWidth / 100);
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeightPercent:(CGFloat)newHeight{
    CGFloat height = 0;
    CGRect frame = self.frame;
    if (self.superview) height = self.superview.frame.size.height * (newHeight / 100);
    frame.size.height = height;
    self.frame = frame;
}

- (UIColor*)shadow{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadow:(UIColor*)color{
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = 0;
}


- (NSInteger)index{
    NSInteger index = 0;
    UIView *superview = self.superview;
    for (int i=0; i<superview.subviews.count; i++) {
        if ([superview.subviews[i] isEqual:self]) return i;
    }
    return index;
}

- (UIView*)subviewAtIndex:(NSInteger)index{
    UIView *subview = nil;
    for (NSInteger i=0; i<self.subviews.count; i++) {
        if (i == index) return self.subviews[i];
    }
    return subview;
}

- (UIView*)firstSubview{
    return self.subviews.firstObject;
}

- (UIView*)lastSubview{
    return self.subviews.lastObject;
}

- (UIView*)prevView{
    UIView *superview = self.superview;
    if (![superview.subviews.firstObject isEqual:self]) {
        UIView *brother = nil;
        for (int i=0; i<superview.subviews.count; i++) {
            UIView *subview = superview.subviews[i];
            if ([subview isEqual:self]) return brother;
            brother = subview;
        }
    }
    return nil;
}

- (UIView*)prevView:(NSInteger)count{
    if (count==0) return self;
    if (count<0) return [self nextView:labs(count)];
    UIView *view = self.prevView;
    for (NSInteger i=1; i<count; i++) {
        view = view.prevView;
    }
    return view;
}

- (NSMutableArray*)prevViews{
    NSMutableArray *views = [[NSMutableArray alloc]init];
    UIView *superview = self.superview;
    if (![superview.subviews.firstObject isEqual:self]) {
        for (int i=0; i<superview.subviews.count; i++) {
            UIView *subview = superview.subviews[i];
            if ([subview isEqual:self]) break;
            [views addObject:subview];
        }
    }
    return views;
}

- (UIView*)nextView{
    UIView *superview = self.superview;
    if (![superview.subviews.lastObject isEqual:self]) {
        for (int i=0; i<superview.subviews.count; i++) {
            UIView *subview = superview.subviews[i];
            if ([subview isEqual:self]) return superview.subviews[i+1];
        }
    }
    return nil;
}

- (UIView*)nextView:(NSInteger)count{
    if (count==0) return self;
    if (count<0) return [self prevView:labs(count)];
    UIView *view = self.nextView;
    for (NSInteger i=1; i<count; i++) {
        view = view.nextView;
    }
    return view;
}

- (NSMutableArray*)nextViews{
    NSMutableArray *views = [[NSMutableArray alloc]init];
    UIView *superview = self.superview;
    if (![superview.subviews.lastObject isEqual:self]) {
        BOOL start = NO;
        for (int i=0; i<superview.subviews.count; i++) {
            UIView *subview = superview.subviews[i];
            if (start) [views addObject:subview];
            if ([subview isEqual:self]) start = YES;
        }
    }
    return views;
}

- (NSArray*)allSubviews{
    NSMutableArray *subviews = [[NSMutableArray alloc]init];
    for (UIView *subview in self.subviews) {
        [subviews addObject:subview];
        if (subview.subviews.count) {
            NSArray *arr = subview.allSubviews;
            for (UIView *sv in arr) [subviews addObject:sv];
        }
    }
    return [NSArray arrayWithArray:subviews];
}

- (NSArray*)subviewsOfTag:(NSInteger)tag{
    NSMutableArray *subviews = [[NSMutableArray alloc]init];
    for (UIView *subview in self.allSubviews) {
        if (subview.tag == tag) [subviews addObject:subview];
    }
    return [NSArray arrayWithArray:subviews];
}
//- (UIView *)isOfClass:(Class)cls and:(Class)cls2{
//
//    for (UIView *subview in self.subviews) {
//        if ([subview isKindOfClass:cls] || [subview isKindOfClass:cls]){
//            return subview;
//        };
//        if (subview.subviews.count) {
//            UIView * view = [self isOfClass:cls and:cls2];
//            if (view!= nil) {
//                return view;
//            }
//        }
//    }
//    return nil;
//}
- (NSArray*)subviewsOfClass:(Class)cls{
    NSMutableArray *subviews = [[NSMutableArray alloc]init];
    for (UIView *subview in self.allSubviews) {
        if ([subview isKindOfClass:cls]) [subviews addObject:subview];
    }
    return [NSArray arrayWithArray:subviews];
}

- (UIView*)parentOfClass:(Class)cls{
    UIView *parent = self.superview;
    while (![parent isKindOfClass:cls]) {
        parent = parent.superview;
        if (parent==nil) break;
    }
    return parent;
}

- (UIViewController*)parentViewController{
    if (self.superview) {
        for (UIView *next = self.superview; next; next = next.superview) {
            UIResponder *nextResponder = next.nextResponder;
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                return (UIViewController*)nextResponder;
            }
        }
    } else {
        UIResponder *nextResponder = self.nextResponder;
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (BOOL)includeSubview:(UIView*)subview{
    for (UIView *view in self.allSubviews) {
        if ([view isEqual:subview]) return YES;
    }
    return NO;
}

- (BOOL)includeSubviewOfClass:(Class)cls{
    for (UIView *view in self.allSubviews) {
        if ([view isKindOfClass:cls]) return YES;
    }
    return NO;
}

- (void)aboveToView:(UIView*)view{
    if (view==nil) return;
    if (![self.superview includeSubview:view]) return;
    NSInteger i = [self.superview.subviews indexOfObject:self];
    NSInteger j = [self.superview.subviews indexOfObject:view];
    if (i>j) return;
    for (NSInteger k=0; k<(j-i); k++) {
        [self.superview exchangeSubviewAtIndex:i+k withSubviewAtIndex:i+k+1];
    }
}

- (void)belowToView:(UIView*)view{
    if (view==nil) return;
    if (![self.superview includeSubview:view]) return;
    NSInteger i = [self.superview.subviews indexOfObject:self];
    NSInteger j = [self.superview.subviews indexOfObject:view];
    if (i<j) return;
    for (NSInteger k=0; k<(i-j); k++) {
        [self.superview exchangeSubviewAtIndex:i-k withSubviewAtIndex:i-k-1];
    }
}

- (UIView*)cloneView{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (NSArray*)backgroundColors{
    return nil;
}
//背景色渐变
- (void)setBackgroundColors:(NSArray*)backgroundColors{
    NSMutableArray *colors = [[NSMutableArray alloc]init];
    for (UIColor *color in backgroundColors) {
        if (color) [colors addObject:(id)color.CGColor];
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = colors;
    gradient.startPoint = CGPointMake(1, 0.5);
    gradient.endPoint = CGPointMake(0, 0.5);
    [self.layer insertSublayer:gradient atIndex:0];
}

//背景图
- (void)setBackgroundImage:(UIImage*)backgroundImage{
    self.backgroundColor = [UIColor clearColor];
    self.layer.backgroundColor = (__bridge CGColorRef)([UIColor colorWithPatternImage:backgroundImage]);
}

//渐显与渐隐
- (void)opacityIn:(NSTimeInterval)duration completion:(void (^)())completion{
    self.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

- (void)opacityOut:(NSTimeInterval)duration completion:(void (^)())completion{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

- (void)opacityTo:(NSInteger)opacity duration:(NSTimeInterval)duration completion:(void (^)())completion{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = opacity;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

//渐隐且执行后渐显
- (void)opacityFn:(NSTimeInterval)duration afterHidden:(void (^)())afterHidden completion:(void (^)())completion{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (afterHidden!=nil) afterHidden();
        [UIView animateWithDuration:duration animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (completion) completion();
        }];
    }];
}

- (void)fadeIn:(NSTimeInterval)duration completion:(void (^)())completion{
    self.alpha = 0;
    self.hidden = NO;
    [self opacityIn:duration completion:completion];
}

- (void)fadeOut:(NSTimeInterval)duration completion:(void (^)())completion{
    self.alpha = 1;
    [self removeOut:duration completion:completion];
}



//渐隐后删除自身
- (void)removeOut:(NSTimeInterval)duration completion:(void (^)())completion{
    [self opacityOut:duration completion:^{
        [self removeFromSuperview];
        if (completion) completion();
    }];
}

//设置某些角为圆角, UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight
- (void)setRectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

//缩放View
- (void)scaleViewWithPercent:(CGFloat)percent andpercent:(CGFloat)percent2{
    if (percent==0) percent = 0.01;
    self.transform = CGAffineTransformMakeScale(percent, percent2);
}

//动画缩放View
- (void)scaleAnimateWithTime:(NSTimeInterval)time percent:(CGFloat)percent completion:(void (^)())completion{
    if (percent==0) percent = 0.01;
    [UIView animateWithDuration:time animations:^{
        self.transform = CGAffineTransformMakeScale(percent, percent);
    } completion:^(BOOL finished) {
        if (completion!=nil) completion();
    }];
}

//动画缩放View,回弹效果
- (void)scaleAnimateBouncesWithTime:(NSTimeInterval)time percent:(CGFloat)percent completion:(void (^)())completion{
    [self scaleAnimateBouncesWithTime:time percent:percent bounce:0.2 completion:completion];
}
- (void)scaleAnimateBouncesWithTime:(NSTimeInterval)time percent:(CGFloat)percent bounce:(CGFloat)bounce completion:(void (^)())completion{
    if (percent==0) percent = 0.01;
    [self scaleAnimateWithTime:time percent:percent+bounce completion:^{
        [self scaleAnimateWithTime:time percent:percent completion:^{
            if (completion!=nil) completion();
        }];
    }];
}

//角度旋转View
- (void)rotatedViewWithDegrees:(CGFloat)degrees{
    self.transform = CGAffineTransformMakeRotation((M_PI*(degrees)/180.0));
}

//指定中心点旋转View,CGPoint参数为百分比
- (void)rotatedViewWithDegrees:(CGFloat)degrees center:(CGPoint)center{
    CGRect frame = self.frame;
    self.layer.anchorPoint = center; //设置旋转的中心点
    self.frame = frame; //设置anchorPont会使view的frame改变,需重新赋值
    self.transform = CGAffineTransformMakeRotation((M_PI*(degrees)/180.0));
}

//点击
- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    recognizer.delegate = target;
    [self addGestureRecognizer:recognizer];
}
- (void)addTapGestureRecognizerWithTouches:(NSInteger)touches target:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    recognizer.delegate = target;
    recognizer.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:recognizer];
}

//长按
- (void)addLongPressGestureRecognizerWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    recognizer.delegate = target;
    [self addGestureRecognizer:recognizer];
}
- (void)addLongPressGestureRecognizerWithTouches:(NSInteger)touches target:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    recognizer.delegate = target;
    recognizer.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:recognizer];
}
//滑动
- (void)addPanGestureRecognizerWithCompletion:(void (^)(NSMutableDictionary * direction))completion endOK:(void (^)(NSMutableDictionary * directionOK)) completionOK{
    
    if (completion==nil) return;
    self.element[@"completion"] = completion;
    self.element[@"completionOK"] = completionOK;
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    recognizer.delegate = (id)self.parentViewController;
    recognizer.maximumNumberOfTouches = 1;
    recognizer.delaysTouchesBegan = YES;
    [self addGestureRecognizer:recognizer];
}


- (void)handlePan:(UIPanGestureRecognizer*)recognizer{
    
    NSMutableDictionary * direction = [[NSMutableDictionary alloc] init];
    CGPoint translation = [recognizer translationInView:self];
    //    NSLog(@"%@", NSStringFromCGPoint(translation));
    CGFloat pointX = translation.x;
    [direction setValue:@(pointX) forKey:@"CGPointX"];
    void (^completion)(NSMutableDictionary * direction) = self.element[@"completion"];
    completion(direction);
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            if (direction == UISwipeGestureRecognizerDirectionLeft) {
                CGPoint velocity = [recognizer velocityInView:recognizer.view];
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        [direction setValue:@"UIPanGestureRecognizerDirectionDown" forKey:@"UIPanGestureRecognizerDirection"];
                    } else {
                        [direction setValue:@"UIPanGestureRecognizerDirectionUp" forKey:@"UIPanGestureRecognizerDirection"];
                    }
                } else {
                    if (velocity.x > 0) {
                        [direction setValue:@"UIPanGestureRecognizerDirectionRight" forKey:@"UIPanGestureRecognizerDirection"];
                    } else {
                        [direction setValue:@"UIPanGestureRecognizerDirectionLeft" forKey:@"UIPanGestureRecognizerDirection"];
                    }
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            break;
        }
        case UIGestureRecognizerStateEnded: {
            /*
             switch (direction) {
             case UIPanGestureRecognizerDirectionUp: {
             completion(1);
             break;
             }
             case UIPanGestureRecognizerDirectionDown: {
             completion(2);
             break;
             }
             case UIPanGestureRecognizerDirectionLeft: {
             completion(3);
             break;
             }
             case UIPanGestureRecognizerDirectionRight: {
             completion(4);
             break;
             }
             default: {
             completion(0);
             break;
             }
             }
             */
            void (^completionOK)(NSMutableDictionary * directionOK) = self.element[@"completionOK"];
            completionOK(direction);
            //            direction = UIPanGestureRecognizerDirectionUndefined;
            break;
        }
        default:
            break;
    }
    
}

//滑动
- (void)addSwipeGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection)direction target:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    recognizer.delegate = target;
    recognizer.direction = direction;
    [self addGestureRecognizer:recognizer];
}
- (void)addSwipeGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection)direction touches:(NSInteger)touches target:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    recognizer.delegate = target;
    recognizer.direction = direction;
    recognizer.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:recognizer];
}
//增加磨砂玻璃效果
- (void)blur{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: 15] forKey: @"inputRadius"];
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    CGImageRef cgImage = [context createCGImage:resultImage fromRect:self.bounds];
    UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.tag = -1;
    imageView.image = blurredImage;
    UIView *overlay = [[UIView alloc] initWithFrame:self.bounds];
    overlay.tag = -2;
    overlay.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:imageView];
    [self addSubview:overlay];
}
- (void)Unblur{
    [[self viewWithTag:-1] removeFromSuperview];
    [[self viewWithTag:-2] removeFromSuperview];
}

- (void)addBlodColore{
    self.layer.cornerRadius = 5;
    
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95].CGColor;
    
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 2.0;
    
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.layer.shouldRasterize = YES;
    
    self.layer.rasterizationScale=[UIScreen mainScreen].scale;
    
}
//点击绑定block
- (void)click:(void(^)(UIView *view))block{
    if (!block) return;
    self.element[@"block"] = block;
    [self addTapGestureRecognizerWithTarget:self action:@selector(onClick:)];
}
- (void)onClick:(UIGestureRecognizer*)sender{
    
    //这里是关键，点击按钮后先取消之前的操作，再进行需要进行的操作
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonClicked:) object:sender];
    [self performSelector:@selector(buttonClicked:)withObject:sender afterDelay:0.5f];
    
}

- (void)buttonClicked:(UIGestureRecognizer*)sender{
    
    void(^block)(UIView *view) = sender.view.element[@"block"];
    block(sender.view);
}
//长按绑定block
- (void)longClick:(void(^)(UIView *view))block{
    if (!block) return;
    self.element[@"block"] = block;
    [self addLongPressGestureRecognizerWithTarget:self action:@selector(onLongClick:)];
}
- (void)onLongClick:(UIGestureRecognizer*)sender{
    if (sender.state == UIGestureRecognizerStateBegan) {
        void(^block)(UIView *view) = sender.view.element[@"block"];
        block(sender.view);
    }
}
@end


//#pragma mark - UIWindow+GlobalExtend
//@implementation UIWindow (GlobalExtend)
//- (UIViewController*)currentController{
//    UIViewController *controller = self.rootViewController;
//    if ([controller isKindOfClass:[UITabBarController class]]) {
//        controller = ((UITabBarController*)controller).selectedViewController;
//    }
//    if ([controller isKindOfClass:[LeftSlideViewController class]]) {
//        controller = ((LeftSlideViewController*)controller).mainVC;
//        if ([controller isKindOfClass:[UINavigationController class]]) {
//            controller = ((UINavigationController*)controller).viewControllers.lastObject;
//        }
//    }
//    if ([controller isKindOfClass:[UINavigationController class]]) {
//        controller = ((UINavigationController*)controller).viewControllers.lastObject;
//    }
//    return controller;
//}
//@end
//
