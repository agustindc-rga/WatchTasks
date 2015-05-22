//
//  WTTaskResponse.h
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import <Foundation/Foundation.h>
#import "WTDictionaryCoding.h"

@interface WTTaskResponse : NSObject <WTDictionaryCoding>

@property (nonatomic, readonly) NSMutableDictionary *data;

- (void)mergeWithResponse:(WTTaskResponse*)response;

@end


@interface WTTaskResponse (ErrorMessage)

+ (instancetype)responseWithErrorMessage:(NSString*)errorMessage DEPRECATED_ATTRIBUTE;
@property (nonatomic) NSString *errorMessage DEPRECATED_ATTRIBUTE;

@end


typedef void(^WTTaskReponseBlock)(WTTaskResponse *response);
@interface WTTaskResponse (ResponseSetup)

+ (void)setupResponseWithBlock:(WTTaskReponseBlock)block completion:(WTTaskReponseBlock)completion;

@end
