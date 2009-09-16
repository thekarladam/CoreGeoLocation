//
//  CGLGeoLocation.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import "CGLGeoLocation.h"

@interface CGLGeoLocation ()
@property (nonatomic, readwrite, copy) NSString *address;
@property (nonatomic, readwrite, copy) NSString *city;
@property (nonatomic, readwrite, copy) NSString *state;
@property (nonatomic, readwrite, retain) NSString *zip;
@property (nonatomic, readwrite, copy) NSString *country;
@property (nonatomic, readwrite, retain) CLLocation *coreLocation;

@end

@implementation CGLGeoLocation

- (id)initWithAddress:(NSString *)inAddress city:(NSString *)inCity state:(NSString *)inState zip:(NSString *)inZip country:(NSString *)inCountry andCoreLocation:(CLLocation *)inLocation {
	if (self = [super init]) {
		self.address = inAddress;
		self.city = inCity;
		self.state = inState;
		self.zip = inZip;
		self.country = inCountry;
		self.coreLocation = inLocation;
	}
	return self;
}

- (id)initWithName:(NSString *)inName andCoreLocation:(CLLocation *)inLocation {
	if (self = [super init]) {
		self.name = inName;
		self.coreLocation = inLocation;
	}
	return self;
}

- (oneway void)dealloc {
	self.address = nil;
	self.city = nil;
	self.state = nil;
	self.zip = nil;
	self.country = nil;
	self.coreLocation = nil;
	
	[super dealloc];
}

@synthesize name = name_;
@synthesize address = address_;
@synthesize city = city_;
@synthesize state = state_;
@synthesize zip = zip_;
@synthesize country = country_;
@synthesize coreLocation = coreLocation_;

#pragma mark -

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@:%p name: \"%@\" address: \"%@\" city: \"%@\" state: \"%@\" zip: %@ country: %@ location: %@>", NSStringFromClass([self class]), self, name_, address_, city_, state_, zip_, country_, coreLocation_];
}

@end
