//
//  AbstractDELETEAPICall.h
//   
//
//  Created by Kamil Burczyk on 08.04.2013.
//  Copyright (c) 2013 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

extern NSString *const kServerURLString;

@interface AbstractDELETEAPICall : NSObject

- (void) executeAPICallWithSuccessBlock:(void (^)(id responseObject)) blockSuccess failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error)) blockFailure;

@end
