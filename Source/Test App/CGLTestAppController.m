//
//  CGLTestAppController.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. All rights reserved.
//

#import "CGLTestAppController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreGeoLocation/CoreGeoLocation.h>

#define kYahooApplicationID @""
#define kGoogleAPIKey @""

@implementation CGLTestAppController

@synthesize currentGeoRequest;

- (void)awakeFromNib {
	if ([kYahooApplicationID length]) {	
		CGLGeoDataProviderYahoo *yahooDataProvider = [[CGLGeoDataProviderYahoo alloc] init];
		[yahooDataProvider setApplicationID:kYahooApplicationID];
		[[CGLGeoManager sharedManager] setDataProvider:yahooDataProvider];
		[yahooDataProvider release];	
		[[CGLGeoManager sharedManager] setDelegate:self];
	} else if ([kGoogleAPIKey length]) {
		CGLGeoDataProviderGoogle *googleDataProvider = [[CGLGeoDataProviderGoogle alloc] init];
		[googleDataProvider setApiKey:kGoogleAPIKey];
		[[CGLGeoManager sharedManager] setDataProvider:googleDataProvider];
		[googleDataProvider	release];
		[[CGLGeoManager sharedManager] setDelegate:self];
	} else {
		[NSException raise:@"Missing Y! AppID or Google API Key" format:@"You Need to provide either an Yahoo! application ID for Yahoo!'s GeoPlanet APIs or a Google API Key for using Google's Geo Web Services"];
	}
}

- (IBAction)lookup:(id)sender {
	NSString *locationAddress = [locationTextField stringValue];
	NSString *latitude = [latitudeTextField stringValue];
	NSString *longitude = [longitudeTextField stringValue];

	
	if ([locationAddress length]) {
		[progressIndicator setHidden:NO];
		[progressIndicator startAnimation:self];
		
		CGLGeoRequest *geoRequest = [[CGLGeoManager sharedManager] determineGeographicalNameForAddress:locationAddress];		
		self.currentGeoRequest = geoRequest;
	} else if ([latitude length] && [longitude length]) {
		CLLocation *location = [[[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]] autorelease];
		CGLGeoRequest *geoRequest = [[CGLGeoManager sharedManager] determineGeographicalNameForLocation:location];
		self.currentGeoRequest = geoRequest;
	}
}

- (void)geoManager:(CGLGeoManager *)inGeoManager determinedLocation:(CGLGeoLocation *)inLocation forRequest:(CGLGeoRequest *)inRequest {
	[progressIndicator setHidden:YES];
	[progressIndicator stopAnimation:self];
	[outputTextView setString:[inLocation description]];
}

@end
