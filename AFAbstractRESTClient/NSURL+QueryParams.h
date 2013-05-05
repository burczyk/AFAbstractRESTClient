//
//  NSURL+QueryParams.h
//  
//
//  Created by Kamil Burczyk on 12.12.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+NSURL.h"

@interface NSURL (QueryParams)

+ (NSURL*) URLWithPath: (NSString*) path andParams: (NSDictionary*) params;

@end
