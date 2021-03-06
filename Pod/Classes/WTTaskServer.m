//
//  WTTaskServer.m
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import "WTTaskServer.h"
#import "WTTaskRequest.h"
#import "WTTaskResponse+NSError.h"
#import "WTTask.h"


@interface WTTaskServerEntry : NSObject

@property (nonatomic) int priority;
@property (nonatomic) Class<WTTask> taskClass;

@end

@implementation WTTaskServerEntry
@end



@interface WTTaskServer ()

@property (nonatomic, strong) NSMutableArray *classRegistry;
@property (nonatomic, strong) NSMutableSet *currentTasks;

@end

@implementation WTTaskServer

- (id)init
{
    if (self = [super init]) {
        self.classRegistry = [[NSMutableArray alloc] init];
        self.currentTasks = [[NSMutableSet alloc] init];
    }
    return self;
}

#pragma mark - Registration

- (void)registerClass:(Class<WTTask>)taskClass
{
    [self registerClass:taskClass priority:0];
}
- (void)registerClass:(Class<WTTask>)taskClass priority:(int)priority
{
    NSUInteger idx = [self.classRegistry indexOfObjectPassingTest:
                      ^BOOL(WTTaskServerEntry *entry, NSUInteger idx, BOOL *stop) {
                          return (entry.priority > priority);
                      }];
    
    WTTaskServerEntry *entry = [[WTTaskServerEntry alloc] init];
    entry.priority = priority;
    entry.taskClass = taskClass;
    
    if (idx == NSNotFound) {
        [self.classRegistry addObject:entry];
    } else {
        [self.classRegistry insertObject:entry atIndex:idx];
    }
}

#pragma mark - Handling Requests
#pragma mark Public

- (void)handleTaskRequest:(WTTaskRequest*)request reply:(void(^)(NSDictionary *replyInfo))reply
{
    @try {
        NSMutableArray *tasks = [[NSMutableArray alloc] init];
        for (WTTaskServerEntry *entry in self.classRegistry) {
            Class taskClass = entry.taskClass;
            if ([taskClass canHandleTaskRequest:request]) {
                id<WTTask> task = [[taskClass alloc] init];
                if (task)
                    [tasks addObject:task];
            }
        }
        
        if (tasks.count == 0) {
            WTTaskResponse *response = [WTTaskResponse responseWithErrorCode:WTTaskErrorNoHandler 
                                                                     message:@"ERROR: no task handler found"];
            [self handleResponse:response withReplyBlock:reply];
            return;
        }
        
        [self handleTaskRequest:request withTasks:tasks previousResponse:nil reply:reply];
        
    } @catch(NSException *exception) {
        WTTaskResponse *response = [WTTaskResponse responseWithErrorCode:WTTaskErrorException 
                                                                 message:exception.reason];
        [self handleResponse:response withReplyBlock:reply];
    }
}

#pragma mark Private

- (void)handleResponse:(WTTaskResponse*)response withReplyBlock:(void(^)(NSDictionary *replyInfo))reply
{
    if (reply)
        reply([response convertToDictionary]);
}

- (void)handleTaskRequest:(WTTaskRequest *)request
                withTasks:(NSArray*)tasks
         previousResponse:(WTTaskResponse *)previousResponse
                    reply:(void(^)(NSDictionary *replyInfo))reply
{
    // execute the first task
    id<WTTask> task = [tasks firstObject];
    [self.currentTasks addObject:task];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(task) weakTask = task;
    
    [task handleTaskRequest:request completion:^(WTTaskResponse *response) {
        [weakSelf.currentTasks removeObject:weakTask];
        
        // error handling
        if (response.error || tasks.count == 1) {
            [weakSelf handleResponse:response withReplyBlock:reply];
            return;
        }
        
        // merge response data
        [previousResponse mergeWithResponse:response];
        
        // execute remaining tasks
        NSArray *remainingTasks = [tasks subarrayWithRange:NSMakeRange(1, tasks.count-1)];
        [weakSelf handleTaskRequest:request
                          withTasks:remainingTasks
                   previousResponse:(previousResponse ?: response)
                              reply:reply];
    }];
}

@end


@implementation WTTaskServer (Application)

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply
{
    //Apple Code- currently there isn't enough time alloced for the watch task so a background task has to be made
    //This should be fixed in a later OS version
    __block UIBackgroundTaskIdentifier identifier = UIBackgroundTaskInvalid;
    dispatch_block_t endBlock = ^ {
        if (identifier != UIBackgroundTaskInvalid) {
            [application endBackgroundTask:identifier];
        }
        identifier = UIBackgroundTaskInvalid;
    };
    
    identifier = [application beginBackgroundTaskWithExpirationHandler:endBlock];
    //
    
    WTTaskRequest *request = [[WTTaskRequest alloc] initWithDictionary:userInfo];
    [self handleTaskRequest:request reply:^(NSDictionary *replyInfo) {
        reply(replyInfo);
        
        dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
        dispatch_after(when, dispatch_get_main_queue(), endBlock);
    }];
}

@end

