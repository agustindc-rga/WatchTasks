//
//  WTTaskResponse+NSError.h
//  Pods
//
//  Created by Agustín de Cabrera on 5/22/15.
//
//

#import "WTTaskResponse.h"

@interface WTTaskResponse (NSError)

extern NSString *const WTTaskErrorDomain;
enum {
    WTTaskErrorUnknown = -1,
    WTTaskErrorNoHandler = 1001,
    WTTaskErrorException = 1002,
};

+ (NSError*)errorWithCode:(NSInteger)errorCode message:(NSString*)errorMessage;

///
+ (instancetype)responseWithErrorCode:(NSInteger)errorCode message:(NSString*)errorMessage;
@property (nonatomic) NSError *error;

@end

