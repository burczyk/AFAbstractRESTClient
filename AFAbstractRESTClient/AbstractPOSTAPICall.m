//
//  AbstractPOSTAPICall.m
//   
//
//  Created by Kamil Burczyk on 29.03.2013.
//  Copyright (c) 2013 Kamil Burczyk. All rights reserved.
//

#import "AbstractPOSTAPICall.h"
#import "AFHTTPRequestOperation.h"
#import "NSURL+QueryParams.h"
#import "NSDictionary+NSURL.h"

@implementation AbstractPOSTAPICall

- (void) executeAPICallWithSuccessBlock:(void (^)(id responseObject)) blockSuccess failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error)) blockFailure progress: (void (^)(long long totalBytesWritten, long long totalBytesExpectedToWrite)) blockProgress {
    NETWORK_ON;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kServerURLString]];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:HTTP_METHOD_POST path:[self path] parameters:[self queryParams] constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [self constructBody:formData];
    }];
    
    NSLog(@"AbstractPOSTAPICall: %@\nRequest headers: %@\n", request.URL, request.allHTTPHeaderFields);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"AbstractPOSTAPICall Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
        if (blockProgress) blockProgress(totalBytesWritten, totalBytesExpectedToWrite);
    }];


    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"AbstractPOSTAPICall SUCCESS with URL: %@\n body:%@\n", request.URL, responseString);
            
            [self parseResponseData:[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil] withCompletionBlockSuccess:blockSuccess];
        } else {
            NSLog(@"AbstractPOSTAPICall SUCCESS with URL: %@\nbody empty", request.URL);
            if (blockSuccess) blockSuccess(responseObject);
        }

        NETWORK_OFF;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"executeAPICall FAILURE with URL: %@\n\n", request.URL);
        NSLog(@"executeAPICall FAILURE Headers: %@\n\n", request.allHTTPHeaderFields);
        NSLog(@"executeAPICall FAILURE body: %@\n\n", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        NSLog(@"executeAPICall FAILURE error: %@\n",error);
        
        if (blockFailure) blockFailure(operation, error);

        NETWORK_OFF;
        
    }];
    
    [operation start];
}

#pragma mark abstract methods

- (NSString*) path {
    MUST_OVERRIDE;
    return nil;
}

- (NSDictionary*) queryParams {
    return nil;
}

- (NSDictionary*) postParams {
    return nil;
}

- (void) constructBody:(id <AFMultipartFormData>) formData {
    return;
}

- (void) parseResponseData: (id) JSON withCompletionBlockSuccess:(void (^)(id responseObject)) blockSuccess {
    if (blockSuccess != nil) blockSuccess(JSON);
    return;
}

@end
