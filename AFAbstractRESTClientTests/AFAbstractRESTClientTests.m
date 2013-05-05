//
//  AFAbstractRESTClientTests.m
//  AFAbstractRESTClientTests
//
//  Created by Kamil Burczyk on 05.05.2013.
//  Copyright (c) 2013 Kamil Burczyk. All rights reserved.
//

#import "AFAbstractRESTClientTests.h"
#import "GitHubGETCall.h"
#import "HttpBinPOSTCall.h"

NSString *const kServerURLString = @"http://httpbin.org";

@implementation AFAbstractRESTClientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testGET {
    __block BOOL downloadComplete = NO;
    
    GitHubGETCall *call = [[GitHubGETCall alloc] init];
    [call executeAPICallWithSuccessBlock:^(id responseObject) {
        downloadComplete = YES;
    } failure:^(NSError *error, id responseObject) {
        downloadComplete = YES;
    }];
    
    //stop test until finish - based on: http://stackoverflow.com/a/2162816/2012064
    // Begin a run loop terminated when the downloadComplete it set to true
    while (!downloadComplete && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

}

- (void) testPOST {
    __block BOOL downloadComplete = NO;
    
    HttpBinPOSTCall *call = [[HttpBinPOSTCall alloc] init];
    [call executeAPICallWithSuccessBlock:^(id responseObject) {
        downloadComplete = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        downloadComplete = YES;
    } progress:^(long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    }];
    
    while (!downloadComplete && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
}

@end
