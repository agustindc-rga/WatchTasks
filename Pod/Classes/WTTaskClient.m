//
//  WTTaskClient.m
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import "WTTaskClient.h"
#import "WTTaskRequest.h"
#import "WTTaskResponse+NSError.h"
#import <WatchKit/WatchKit.h>

@implementation WTTaskClient

- (void)sendTaskRequest:(WTTaskRequest*)request completion:(void(^)(WTTaskResponse* response))completion
{
    [WKInterfaceController openParentApplication:[request convertToDictionary] reply:^(NSDictionary *replyInfo, NSError *error) {
        
        WTTaskResponse *response = [[WTTaskResponse alloc] initWithDictionary:replyInfo];
        
        if (!response.error && error) {
            response.error = error;
        }
        
        if (completion)
            completion(response);
    }];
}

@end
