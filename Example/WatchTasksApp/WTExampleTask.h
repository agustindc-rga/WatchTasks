//
//  WTExampleTask.h
//  WatchTasks
//
//  Created by Agustín de Cabrera on 2/3/15.
//  Copyright (c) 2015 Agustín de Cabrera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchTasks/WatchTasks.h>

/*
 task type: "ExampleTask"
 parameters:
    "name": string
 response data:
    "message": string
 */

@interface WTExampleTask : NSObject <WTTask>

@end
