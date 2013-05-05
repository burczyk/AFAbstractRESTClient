//
//  NSURL+QueryParams.m
//  
//
//  Created by Kamil Burczyk on 12.12.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import "NSURL+QueryParams.h"

@implementation NSURL (QueryParams)

+ (NSURL*) URLWithPath: (NSString*) path andParams: (NSDictionary*) params {
    return (params != nil) ? [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", path, [params getAsQueryParams]]] : [NSURL URLWithString:path];
}

@end
