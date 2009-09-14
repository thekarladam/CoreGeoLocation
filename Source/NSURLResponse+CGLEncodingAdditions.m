//
//  NSURLResponse+CGLEncodingAdditions.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import "NSURLResponse+CGLEncodingAdditions.h"


@implementation NSURLResponse (CGLEncodingAdditions)

- (NSStringEncoding)cglEncoding {
	NSStringEncoding encoding = NSUTF8StringEncoding;
	
	if ([self textEncodingName]) {
		CFStringEncoding cfStringEncoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)[self textEncodingName]);
		if (cfStringEncoding != kCFStringEncodingInvalidId) {
			encoding = CFStringConvertEncodingToNSStringEncoding(cfStringEncoding); 
		}
	}
	
	return encoding;	
}

@end
