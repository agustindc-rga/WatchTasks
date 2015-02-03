//
//  WTDictionaryCoding.h
//  Pods
//
//  Created by Agustín de Cabrera on 2/3/15.
//
//

#import <Foundation/Foundation.h>

@protocol WTDictionaryCoding <NSObject>

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (NSDictionary*)convertToDictionary;

@end
