//
//  AppDelegate.m
//  CodePasta
//
//  Created by Mohamed Gwely on 22/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"ZFPgsmDvyf7eDE4FsomXOvOUiwgf4mqIkAWiFXnX"
                  clientKey:@"JZ7Ves2gYMNPU0ZQJoXypk86KJUoOvB3LkN5S3Mt"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    
    //If user is not logged in
    if (![PFUser currentUser])
    {
        UIViewController* rootController = [[UIStoryboard storyboardWithName: MAIN_STORYBOARD
                                                                      bundle:[NSBundle mainBundle]]
                                            instantiateViewControllerWithIdentifier: LOGIN_VIEW_CONTROLLER_IDENTIFIER];
        
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];

        self.window.rootViewController = navigation;

    }
    else
    {
        self.window.rootViewController = [[UIStoryboard storyboardWithName: MAIN_STORYBOARD bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
    
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
