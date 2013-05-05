//
//  AbstractDELETEAPICall.m
//   
//
//  Created by Kamil Burczyk on 08.04.2013.
//  Copyright (c) 2013 Kamil Burczyk. All rights reserved.
//

#import "AbstractDELETEAPICall.h"
#import "AFHTTPRequestOperation.h"
#import "NSURL+QueryParams.h"
#import "NSDictionary+NSURL.h"

@implementation AbstractDELETEAPICall

- (void) executeAPICallWithSuccessBlock:(void (^)(id responseObject)) blockSuccess failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error)) blockFailure {
    NETWORK_ON;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kServerURLString]];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:HTTP_METHOD_DELETE path:[self path] parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {    
    }];
    
    NSLog(@"AbstractDELETEAPICall: %@\nRequest headers: %@\n", request.URL, request.allHTTPHeaderFields);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"AbstractDELETEAPICall SUCCESS with URL: %@\n body:%@\n", request.URL, responseString);
        
        if (responseString != nil && [responseString length] > 0) {
            [self parseResponseData:[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil] withCompletionBlockSuccess:blockSuccess];
        } else {
            if(blockSuccess) blockSuccess(responseObject);
        }
        
        NETWORK_OFF;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"executeAPICall FAILURE with URL: %@\n\n", request.URL);
        NSLog(@"executeAPICall FAILURE Headers: %@\n\n", request.allHTTPHeaderFields);
        NSLog(@"executeAPICall FAILURE body: %@\n\n", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        NSLog(@"executeAPICall FAILURE error: %@\n",error);
        
        if(blockFailure) blockFailure(operation, error);
        
        NETWORK_OFF;
        
    }];
    [operation start];
}

#pragma mark abstract methods

- (NSString*) path {
    MUST_OVERRIDE;
    return nil;
}

- (void) parseResponseData: (id) JSON withCompletionBlockSuccess:(void (^)(id responseObject)) blockSuccess {
    if(blockSuccess) blockSuccess(JSON);
    return;
}

@end
