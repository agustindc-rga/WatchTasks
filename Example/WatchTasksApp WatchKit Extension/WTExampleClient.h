//
//  WTExampleClient.h
//  WatchTasksApp
//
//  Created by Agustín de Cabrera on 2/4/15.
//  Copyright (c) 2015 Agustín de Cabrera. All rights reserved.
//

#import <WatchTasks/WatchTasks.h>

@interface WTExampleClient : WTTaskClient

+ (instancetype)sharedClient;

- (void)performExampleTaskWithName:(NSString*)name completion:(void(^)(NSString *message))completion;

@end
