//
//  WTTaskServer.h
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import <UIKit/UIKit.h>
@class WTTaskRequest;
@class WTTaskResponse;
@protocol WTTask;


@interface WTTaskServer : NSObject

- (void)registerClass:(Class<WTTask>)taskClass;
- (void)registerClass:(Class<WTTask>)taskClass priority:(int)priority;

- (void)handleTaskRequest:(WTTaskRequest*)request reply:(void(^)(NSDictionary *replyInfo))reply;

@end


@interface WTTaskServer (Application)

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply;

@end
