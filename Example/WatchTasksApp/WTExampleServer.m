//
//  WTExampleServer.m
//  WatchTasksApp
//
//  Created by Agustín de Cabrera on 2/4/15.
//  Copyright (c) 2015 Agustín de Cabrera. All rights reserved.
//

#import "WTExampleServer.h"
#import "WTExampleTask.h"

@implementation WTExampleServer

+ (instancetype)sharedServer
{
    static WTExampleServer *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
        [sharedInstance registerClass:[WTExampleTask class]];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerClass:[WTExampleTask class]];
    }
    return self;
}

@end
