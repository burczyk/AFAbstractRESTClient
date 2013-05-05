//
//  NSDictionary+NSData.h
//  
//
//  Created by Kamil Burczyk on 12.12.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSURL)

- (NSString*) getAsQueryParams;

+ (NSDictionary *)URLQueryParameters:(NSURL *)URL;

@end
