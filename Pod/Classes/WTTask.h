//
//  WTTask.h
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import <Foundation/Foundation.h>
@class WTTaskRequest;
@class WTTaskResponse;

@protocol WTTask <NSObject>

+ (BOOL)canHandleTaskRequest:(WTTaskRequest*)request;

- (void)handleTaskRequest:(WTTaskRequest*)request completion:(void(^)(WTTaskResponse *response))completion;

@end
