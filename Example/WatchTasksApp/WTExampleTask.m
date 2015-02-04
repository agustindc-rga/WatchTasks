//
//  WTExampleTask.m
//  WatchTasks
//
//  Created by Agustín de Cabrera on 2/3/15.
//  Copyright (c) 2015 Agustín de Cabrera. All rights reserved.
//

#import "WTExampleTask.h"

@implementation WTExampleTask

+(BOOL)canHandleTaskRequest:(WTTaskRequest *)request
{
    return [request.taskType isEqualToString:@"ExampleTask"];
}

-(void)handleTaskRequest:(WTTaskRequest *)request completion:(void (^)(WTTaskResponse *))completion
{
    [WTTaskResponse setupResponseWithBlock:^(WTTaskResponse *response) {
        
        // get the name from the request parameters
        NSString *name = request.parameters[@"name"];
        
        // return a message
        response.data[@"message"] = [NSString stringWithFormat:@"Hello %@!", name];
        
    } completion:completion];
}

@end
