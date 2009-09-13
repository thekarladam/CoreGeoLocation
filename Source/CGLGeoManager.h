//
//  CGLGeoManager.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CGLGeoDataProvider.h"

@class CGLGeoRequest;
@class CGLGeoLocation;
@class CGLGeoDataProvider;

@protocol CGLGeoManagerDelegate;

@interface CGLGeoManager : NSObject <CGLGeoDataProviderDelegate> {
	NSMutableArray				*outstandingRequests_;
	CGLGeoDataProvider			*dataProvider_;
	id <CGLGeoManagerDelegate>	delegate_;
}

@property (nonatomic, readwrite, retain) CGLGeoDataProvider *dataProvider;
@property (nonatomic, readwrite, assign) id <CGLGeoManagerDelegate> delegate;

+ (CGLGeoManager *)sharedManager;

- (void)determineGeographicalNameWithRequest:(CGLGeoRequest *)inRequest;
- (CGLGeoRequest *)determineGeographicalNameForAddress:(NSString *)inAddress;
- (CGLGeoRequest *)determineGeographicalNameForLocation:(CLLocation *)inLocation;

@end

@protocol CGLGeoManagerDelegate <NSObject>
- (void)geoManager:(CGLGeoManager *)inGeoManager determinedLocation:(CGLGeoLocation *)inLocation forRequest:(CGLGeoRequest *)inRequest;
@end