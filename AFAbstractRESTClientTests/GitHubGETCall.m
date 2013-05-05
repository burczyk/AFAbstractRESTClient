//
//  GitHubGETCall.m
//  AFAbstractRESTClient
//
//  Created by Kamil Burczyk on 05.05.2013.
//  Copyright (c) 2013 Kamil Burczyk. All rights reserved.
//

#import "GitHubGETCall.h"

@implementation GitHubGETCall

- (NSString*) path {
    return @"https://api.github.com/repos/burczyk/AFAbstractRESTClient";
}

- (void) parseResponseData: (id) JSON withSuccessBlock:(void (^)(id JSON)) blockSuccess {
    // You can parse your data here, e.g. write them to Core Data/SQLite or create your own model.
    // After parsing you can return either JSON or parsed object as input for block is (id)
    blockSuccess(JSON);
}

- (NSMutableURLRequest*) decorateRequestIfNeeded: (NSMutableURLRequest*) request {
    [request setValue:@"AFAbstractRESTClient" forHTTPHeaderField:@"User-Agent"];
    return request;
}

@end
