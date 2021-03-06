//
//  WTAppDelegate.m
//  WatchTasks
//
//  Created by CocoaPods on 02/03/2015.
//  Copyright (c) 2014 Agustín de Cabrera. All rights reserved.
//

#import "WTAppDelegate.h"
#import "WTExampleServer.h"

@implementation WTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        WTTaskRequest *request = [[WTTaskRequest alloc] initWithTaskType:@"ExampleTask"];
        request.parameters[@"name"] = @"aName";
        
        [self application:application handleWatchKitExtensionRequest:[request convertToDictionary] reply:^(NSDictionary *replyInfo) {
           
            NSLog(@"reply: %@", replyInfo);
            WTTaskResponse *response = [[WTTaskResponse alloc] initWithDictionary:replyInfo];
            NSLog(@"response: %@", response);
        }];
    });
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - WatchKit Requests

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply
{
    [[WTExampleServer sharedServer] application:application handleWatchKitExtensionRequest:userInfo reply:reply];
}

@end
