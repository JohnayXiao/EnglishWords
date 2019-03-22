//
//  XJNavigationController.m
//  知识
//
//  Created by Johnay  on 2018/2/11.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "XJNavigationController.h"

@interface XJNavigationController ()

@end

@implementation XJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
//    self.navigationBar.barTintColor = ThemeColor;
    
    self.navigationBar.tintColor = [UIColor whiteColor];

    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        
//        self.interactivePopGestureRecognizer.enabled = YES;
//        // 右滑返回
//        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//
//            self.interactivePopGestureRecognizer.delegate = nil;
//        }
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [self.view.layer addAnimation:animation forKey:@"animation"];
        
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)backAction {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self.view.layer addAnimation:animation forKey:@"animation"];
    [self popViewControllerAnimated:YES];
}

@end
