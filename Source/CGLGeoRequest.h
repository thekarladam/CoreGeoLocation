//
//  CGLGeoRequest.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CGLGeoRequest : NSObject {
	NSString	*address_;
	CLLocation	*location_;
}

@property (nonatomic, readonly, copy) NSString *address;
@property (nonatomic, readonly, retain) CLLocation *location;

- (id)initWithLocation:(CLLocation *)inLocation;
- (id)initWithAddress:(NSString *)inAddress;

@end
