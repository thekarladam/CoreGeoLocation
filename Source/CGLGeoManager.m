//
//  CGLGeoManager.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import "CGLGeoManager.h"
#import "CGLGeoRequest.h"
#import "CGLGeoDataProvider.h"

static CGLGeoManager *_theStaticGeoManagerInstance = nil;

@interface CGLGeoManager ()
@property (nonatomic, readwrite, retain) NSMutableArray *outstandingRequests;
@end

@implementation CGLGeoManager

+ (CGLGeoManager *)sharedManager {
	if (!_theStaticGeoManagerInstance) {
		_theStaticGeoManagerInstance = [[self alloc] init];
	}
	
	return _theStaticGeoManagerInstance;
}

- (id)init {
	if (self = [super init]) {
		self.outstandingRequests = [NSMutableArray arrayWithCapacity:15];
	}
	return self;
}

- (oneway void)dealloc {
	self.dataProvider = nil;
	self.delegate = nil;
	self.outstandingRequests = nil;
	
	[super dealloc];
}

@synthesize dataProvider = dataProvider_;
@synthesize delegate = delegate_;
@synthesize outstandingRequests = outstandingRequests_;

- (void)setDataProvider:(CGLGeoDataProvider *)inDataProvider {
	[inDataProvider retain];
	[dataProvider_ release];
	dataProvider_ = inDataProvider;
	[dataProvider_ setDelegate:self];
}

#pragma mark -

- (void)determineGeographicalNameWithRequest:(CGLGeoRequest *)inRequest {
	[self.dataProvider performRequest:inRequest];
}

- (CGLGeoRequest *)determineGeographicalNameForAddress:(NSString *)inAddress {
	CGLGeoRequest *geoRequest = [[CGLGeoRequest alloc] initWithAddress:inAddress];
	[self determineGeographicalNameWithRequest:geoRequest];
	return geoRequest;
}

- (CGLGeoRequest *)determineGeographicalNameForLocation:(CLLocation *)inLocation {
	CGLGeoRequest *geoRequest = [[CGLGeoRequest alloc] initWithLocation:inLocation];
	[self determineGeographicalNameWithRequest:geoRequest];
	return geoRequest;
}

#pragma mark -

- (void)geoLocation:(CGLGeoLocation *)inGeoLocation determinedForRequest:(CGLGeoRequest *)inRequest {
	[self.delegate geoManager:self determinedLocation:inGeoLocation forRequest:inRequest];
}

@end
