//
//  CGLGeoLocation.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CGLGeoLocation : NSObject {
	NSString	*name_;
	NSString	*address_;
	NSString	*city_;
	NSString	*state_;
	NSString	*zip_;
	NSString	*country_;
	CLLocation	*coreLocation_;
}

@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *address;
@property (nonatomic, readonly, copy) NSString *city;
@property (nonatomic, readonly, copy) NSString *state;
@property (nonatomic, readonly, retain) NSString *zip;
@property (nonatomic, readonly, copy) NSString *country;
@property (nonatomic, readonly, retain) CLLocation *coreLocation;

- (id)initWithAddress:(NSString *)inAddress city:(NSString *)inCity state:(NSString *)inState zip:(NSString *)inZip country:(NSString *)inCountry andCoreLocation:(CLLocation *)inLocation;
- (id)initWithName:(NSString *)inName andCoreLocation:(CLLocation *)inLocation;

@end
