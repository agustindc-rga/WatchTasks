//
//  WTExampleClient.m
//  WatchTasksApp
//
//  Created by Agustín de Cabrera on 2/4/15.
//  Copyright (c) 2015 Agustín de Cabrera. All rights reserved.
//

#import "WTExampleClient.h"

@implementation WTExampleClient

+ (instancetype)sharedClient
{
    static WTExampleClient *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)performExampleTaskWithName:(NSString*)name completion:(void(^)(NSString *message))completion
{
    WTTaskRequest *request = [[WTTaskRequest alloc] initWithTaskType:@"ExampleTask"];
    request.parameters[@"name"] = name;
    
    [self sendTaskRequest:request completion:^(WTTaskResponse *response) {

        NSError *error = response.error;
        NSString *message = (error ? error.localizedDescription : response.data[@"message"]);
        
        if (completion)
            completion(message);
    }];
}

@end
