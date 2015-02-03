//
//  WTTaskRequest.h
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import <Foundation/Foundation.h>
#import "WTDictionaryCoding.h"

@interface WTTaskRequest : NSObject <WTDictionaryCoding>

- (instancetype)initWithTaskType:(NSString *)taskType;

@property (nonatomic, readonly) NSString *taskType;
@property (nonatomic, readonly) NSMutableDictionary *parameters;

@end
