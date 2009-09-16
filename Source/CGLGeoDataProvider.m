//
//  CGLGeoDataProvider.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import "CGLGeoDataProvider.h"


@implementation CGLGeoDataProvider

+ (BOOL)canHandleRequest:(CGLGeoRequest *)inRequest {
	return NO;
}

@synthesize delegate = delegate_;

- (BOOL)canHandleRequest:(CGLGeoRequest *)inRequest {
	return [[self class] canHandleRequest:inRequest];
}

- (void)performRequest:(CGLGeoRequest *)inRequest {
	// you lose
}

@end
