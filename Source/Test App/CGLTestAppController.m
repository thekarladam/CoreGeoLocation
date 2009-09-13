//
//  CGLTestAppController.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. All rights reserved.
//

#import "CGLTestAppController.h"
#import <CoreGeoLocation/CoreGeoLocation.h>

#define kApplicationID @""

@implementation CGLTestAppController

@synthesize currentGeoRequest;

- (void)awakeFromNib {
	if (![kApplicationID length]) {
		[NSException raise:@"You Need to provide an application ID for using Yahoo!'s Web Service" format:nil];
	}
	
	CGLGeoDataProviderYahoo *yahooDataProvider = [[CGLGeoDataProviderYahoo alloc] init];
	[yahooDataProvider setApplicationID:kApplicationID];
	[[CGLGeoManager sharedManager] setDataProvider:yahooDataProvider];
	[yahooDataProvider release];
	[[CGLGeoManager sharedManager] setDelegate:self];
}

- (IBAction)lookup:(id)sender {
	NSString *locationAddress = [locationTextField stringValue];
	

	
	if ([locationAddress length]) {
		[progressIndicator setHidden:NO];
		[progressIndicator startAnimation:self];
		
		CGLGeoRequest *geoRequest = [[CGLGeoManager sharedManager] determineGeographicalNameForAddress:locationAddress];		
		self.currentGeoRequest = geoRequest;
	}
}

- (void)geoManager:(CGLGeoManager *)inGeoManager determinedLocation:(CGLGeoLocation *)inLocation forRequest:(CGLGeoRequest *)inRequest {
	[progressIndicator setHidden:YES];
	[progressIndicator stopAnimation:self];
	[outputTextView setString:[inLocation description]];
}

@end
