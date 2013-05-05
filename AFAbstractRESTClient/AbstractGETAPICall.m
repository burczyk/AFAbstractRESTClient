//
//  AbstractGETAPICall.m
//   
//
//  Created by Kamil Burczyk on 20.03.2013.
//  Copyright (c) 2013 Kamil Burczyk. All rights reserved.
//

#import "AbstractGETAPICall.h"
#import "AFJSONRequestOperation.h"
#import "NSURL+QueryParams.h"

@implementation AbstractGETAPICall

- (void) executeAPICallWithSuccessBlock:(void (^)(id responseObject)) blockSuccess failure:(void (^)(NSError *error, id responseObject)) blockFailure {
    NETWORK_ON;
    
    NSDictionary *params = [self queryParams];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithPath:[self path] andParams:params]];
    request = [self decorateRequestIfNeeded:request];

    NSLog(@"AbstractGETAPICall: %@\nRequest headers: %@\n", request.URL, request.allHTTPHeaderFields);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self parseResponseData: JSON withSuccessBlock:^(id JSON) {
            
            NSLog(@"AbstractGETAPICall SUCCESS with URL: %@\n body:%@\n", request.URL, JSON);
            
            if (blockSuccess != nil) blockSuccess(JSON);
            
            NETWORK_OFF;
            
        }];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"executeAPICall FAILURE with URL: %@\n\n", request.URL);
        NSLog(@"executeAPICall FAILURE Headers: %@\n\n", request.allHTTPHeaderFields);
        NSLog(@"executeAPICall FAILURE body: %@\n\n", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        NSLog(@"executeAPICall FAILURE error: %@\n",error);
        
        if (blockFailure != nil) blockFailure(error, JSON);

        NETWORK_OFF;
        
    }];
    [operation start];
}

#pragma mark abstract methods

- (NSString*) path {
    MUST_OVERRIDE;
    return nil;
}

- (void) parseResponseData: (id) JSON withSuccessBlock:(void (^)(id JSON)) blockSuccess {
    MUST_OVERRIDE;
}

- (NSDictionary*) queryParams {
    return nil;
}

- (NSMutableURLRequest*) decorateRequestIfNeeded: (NSMutableURLRequest*) request {
    return request;
}

@end




