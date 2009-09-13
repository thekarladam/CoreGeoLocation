//
//  NSString+CGLURLEscapingAdditions.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Yahoo. All rights reserved.
//

#import "NSString+CGLURLLoadingAdditions.h"


@implementation NSString (CGLURLLoadingAdditions)

- (NSString *)cglEscapedURLEncodedString {
	NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
																		   (CFStringRef)self,
																		   NULL,
																		   (CFStringRef)@";/?:@&=$+{}<>,",
																		   kCFStringEncodingUTF8);
    return [result autorelease];
}

@end
