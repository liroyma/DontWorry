//
//  AppDelegate.m
//  DontWorry2
//
//  Created by Liroy Machluf on 8/30/14.
//  Copyright (c) 2014 Liroy Machluf. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UIViewController *tab1 = [[tabBarController viewControllers] objectAtIndex:0];
    [[tab1 tabBarItem] setTitle:NSLocalizedString(@"Main", comment: "The Close button title")];
    [[tab1 tabBarItem] setImage:[UIImage imageNamed:@"tabBarBubble"]];
    [[tab1 tabBarItem] setSelectedImage:[UIImage imageNamed:@"tabBarBubble"]];
    
    UIViewController *tab2 = [[tabBarController viewControllers] objectAtIndex:1];
    [[tab2 tabBarItem] setTitle:NSLocalizedString(@"Contacts", comment: "The Close button title")];
    [[tab2 tabBarItem] setImage:[UIImage imageNamed:@"tabBarContacts"]];
    [[tab2 tabBarItem] setSelectedImage:[UIImage imageNamed:@"tabBarContacts"]];
    
    UIViewController *tab3 = [[tabBarController viewControllers] objectAtIndex:2];
    [[tab3 tabBarItem] setTitle:NSLocalizedString(@"Messages edit", comment: "The Close button title")];
    [[tab3 tabBarItem] setImage:[UIImage imageNamed:@"tabBarEditBubble"]];
    [[tab3 tabBarItem] setSelectedImage:[UIImage imageNamed:@"tabBarEditBubble"]];
    
    UIViewController *tab4 = [[tabBarController viewControllers] objectAtIndex:3];
    [[tab4 tabBarItem] setTitle:NSLocalizedString(@"Settings", comment: "The Close button title")];
    [[tab4 tabBarItem] setImage:[UIImage imageNamed:@"tabBarSettings"]];
    [[tab4 tabBarItem] setSelectedImage:[UIImage imageNamed:@"tabBarSettings"]];
    
    tabBarController.selectedIndex = 0;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.selectedIndex = 0;
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
