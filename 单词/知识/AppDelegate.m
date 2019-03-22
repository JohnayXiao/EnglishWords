//
//  AppDelegate.m
//  知识
//
//  Created by Johnay  on 2018/2/10.
//  Copyright © 2018年 Johnay. All rights reserved.
//

#import "AppDelegate.h"
#import "XJNavigationController.h"
#import "MainViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[XJNavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"将要加入后台。。。。");
    POST_NOTIFICATION(@"willEnterBackGround");
}


@end
