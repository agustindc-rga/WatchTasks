//
//  WTTaskResponse+NSError.m
//  Pods
//
//  Created by Agustín de Cabrera on 5/22/15.
//
//

#import "WTTaskResponse+NSError.h"

@implementation WTTaskResponse (NSError)

NSString *const WTTaskErrorDomain = @"com.watchtasks.error";
static NSString *const kErrorResponseKey = @"error";

+ (NSError*)errorWithCode:(NSInteger)errorCode message:(NSString*)errorMessage
{
    return [NSError errorWithDomain:WTTaskErrorDomain code:errorCode userInfo:
            @{ NSLocalizedDescriptionKey:errorMessage }];
}

///
+ (instancetype)responseWithErrorCode:(NSInteger)errorCode message:(NSString*)errorMessage;
{
    WTTaskResponse *response = [[WTTaskResponse alloc] init];
    response.error = [self errorWithCode:errorCode message:errorMessage];
    
    return response;
}

-(NSError *)error
{
    NSData *errorData = self.data[kErrorResponseKey];
    NSError *error = [NSKeyedUnarchiver unarchiveObjectWithData:errorData];
    return error;
}
-(void)setError:(NSError *)error
{
    NSData *errorData = [NSKeyedArchiver archivedDataWithRootObject:error];
    [self.data setValue:errorData forKey:kErrorResponseKey];
}

@end

