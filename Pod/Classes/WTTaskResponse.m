//
//  WTTaskResponse.m
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import "WTTaskResponse.h"

@interface WTTaskResponse ()

@property (nonatomic) NSMutableDictionary *data;

@end

@implementation WTTaskResponse

-(NSMutableDictionary *)data
{
    if (!_data) {
        _data = [[NSMutableDictionary alloc] init];
    }
    return _data;
}

- (void)mergeWithResponse:(WTTaskResponse*)response
{
    [self.data addEntriesFromDictionary:response.data];
}

#pragma mark - WTDictionaryCoding

static NSString *const kResponseDataKey = @"data";

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        self.data = [dictionary[kResponseDataKey] mutableCopy];
    }
    return self;
}
- (NSDictionary*)convertToDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.data forKey:kResponseDataKey];
    
    return dict;
}

@end


@implementation WTTaskResponse (ErrorMessage)

static NSString *const kErrorMessageResponseKey = @"error";

+ (instancetype)responseWithErrorMessage:(NSString*)errorMessage
{
    WTTaskResponse *response = [[WTTaskResponse alloc] init];
    response.errorMessage = errorMessage;
    
    return response;
}

-(NSString *)errorMessage
{
    return self.data[kErrorMessageResponseKey];
}
-(void)setErrorMessage:(NSString *)errorMessage
{
    [self.data setValue:errorMessage forKey:kErrorMessageResponseKey];
}

@end

#import "WTTaskResponse+NSError.h"

@implementation WTTaskResponse (ResponseSetup)

+ (void)setupResponseWithBlock:(WTTaskReponseBlock)block completion:(WTTaskReponseBlock)completion
{
    WTTaskResponse *response = [[WTTaskResponse alloc] init];
    
    @try {
        if (block)
            block(response);
    } @catch(NSException *exception) {
        response.error = [self errorWithCode:WTTaskErrorException 
                                     message:exception.reason];
    }
    
    if (completion)
        completion(response);
}

@end
