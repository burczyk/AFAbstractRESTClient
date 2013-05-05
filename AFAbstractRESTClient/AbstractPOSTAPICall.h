//
//  AbstractPOSTAPICall.h
//   
//
//  Created by Kamil Burczyk on 29.03.2013.
//  Copyright (c) 2013 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

extern NSString *const kServerURLString;

@interface AbstractPOSTAPICall : NSObject

- (void) executeAPICallWithSuccessBlock:(void (^)(id responseObject)) blockSuccess failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error)) blockFailure progress: (void (^)(long long totalBytesWritten, long long totalBytesExpectedToWrite)) blockProgress;

@end
