//
//  WTTaskClient.h
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import <Foundation/Foundation.h>
@class WTTaskRequest;
@class WTTaskResponse;

@interface WTTaskClient : NSObject

+ (instancetype)sharedInstance; // not required

- (void)sendTaskRequest:(WTTaskRequest*)request completion:(void(^)(WTTaskResponse* response))completion;

@end
