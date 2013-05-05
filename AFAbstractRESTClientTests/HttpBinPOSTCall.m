//
//  HttpBinPOSTCall.m
//  AFAbstractRESTClient
//
//  Created by Kamil Burczyk on 05.05.2013.
//  Copyright (c) 2013 Kamil Burczyk. All rights reserved.
//

#import "HttpBinPOSTCall.h"

@implementation HttpBinPOSTCall

- (NSString*) path {
    return @"post";
}

- (NSDictionary*) queryParams {
    return @{ @"arg1" : @"value1", @"arg2" : @3.141592 };
}

- (void) constructBody:(id <AFMultipartFormData>) formData {
    
    // image source: http://commons.wikimedia.org/wiki/File:Mila_Kunis_2012.jpg
    NSData *image = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Mila_Kunis_2012.jpg/128px-Mila_Kunis_2012.jpg"]];
    
    [formData appendPartWithFormData:[@"example data" dataUsingEncoding:NSUTF8StringEncoding] name:@"key1"];
    [formData appendPartWithFormData:image name:@"Mila_Kunis_2012.jpg"];
}

@end
