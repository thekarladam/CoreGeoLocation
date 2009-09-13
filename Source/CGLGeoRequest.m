//
//  CGLGeoRequest.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import "CGLGeoRequest.h"

@interface CGLGeoRequest ()
@property (nonatomic, readwrite, copy) NSString *address;
@property (nonatomic, readwrite, retain) CLLocation *location;
@end

@implementation CGLGeoRequest

- (id)initWithLocation:(CLLocation *)inLocation {
	if (self = [super init]) {
		self.location = inLocation;
	}
	return self;
}

- (id)initWithAddress:(NSString *)inAddress {
	if (self = [super init]) {
		self.address = inAddress;
	}
	return self;
}


- (oneway void)dealloc {
	self.address = nil;
	self.location = nil;
	
	[super dealloc];
}

@synthesize address = address_;
@synthesize location = location_;

#pragma mark -

@end
