//
//  WTTaskClient.m
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import "WTTaskClient.h"
#import "WTTaskRequest.h"
#import "WTTaskResponse.h"
#import <WatchKit/WatchKit.h>

@implementation WTTaskClient

+ (instancetype)sharedInstance
{
    static WTTaskClient *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)sendTaskRequest:(WTTaskRequest*)request completion:(void(^)(WTTaskResponse* response))completion
{
    [WKInterfaceController openParentApplication:[request convertToDictionary] reply:^(NSDictionary *replyInfo, NSError *error) {
        
        WTTaskResponse *response = [[WTTaskResponse alloc] initWithDictionary:replyInfo];
        
        if (!response.errorMessage && error) {
            response.errorMessage = error.localizedDescription;
        }
        
        if (completion)
            completion(response);
    }];
}

@end
