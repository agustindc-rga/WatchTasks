//
//  WTTaskRequest.m
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import "WTTaskRequest.h"

@interface WTTaskRequest ()

@property (nonatomic) NSString* taskType;
@property (nonatomic) NSMutableDictionary *parameters;

@end


@implementation WTTaskRequest

- (instancetype)initWithTaskType:(NSString*)taskType
{
    if (self = [self init]) {
        self.taskType = taskType;
    }
    return self;
}

-(NSMutableDictionary *)parameters
{
    if (!_parameters) {
        _parameters = [[NSMutableDictionary alloc] init];
    }
    return _parameters;
}

#pragma mark - WTDictionaryCoding

static NSString *const kTaskTypeKey = @"taskType";
static NSString *const kParametersKey = @"parameters";

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self initWithTaskType:dictionary[kTaskTypeKey]]) {
        self.parameters = [dictionary[kParametersKey] mutableCopy];
    }
    return self;
}
- (NSDictionary*)convertToDictionary
{
    if (self.taskType.length == 0)
        return nil;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.taskType forKey:kTaskTypeKey];
    [dict setValue:self.parameters forKey:kParametersKey];
    
    return dict;
}

@end
