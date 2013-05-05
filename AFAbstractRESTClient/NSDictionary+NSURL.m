//
//  NSDictionary+NSData.m
//  
//
//  Created by Kamil Burczyk on 12.12.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import "NSDictionary+NSURL.h"

@implementation NSDictionary (NSURL)

- (NSString*) getAsQueryParams {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
    return [[NSString stringWithFormat: @"%@", object] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

+ (NSDictionary *)URLQueryParameters:(NSURL *)URL {
    NSString *queryString = [URL query];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *parameters = [queryString componentsSeparatedByString:@"&"];
    for (NSString *parameter in parameters)
    {
        NSArray *parts = [parameter componentsSeparatedByString:@"="];
        NSString *key = [[parts objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([parts count] > 1)
        {
            id value = [[parts objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [result setObject:value forKey:key];
        }
    }
    return result;
}

@end
