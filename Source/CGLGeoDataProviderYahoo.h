//
//  CGLGeoDataProviderYahoo.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import <Foundation/Foundation.h>
#import "CGLGeoDataProvider.h"

@interface CGLGeoDataProviderYahoo : CGLGeoDataProvider {
	NSString				*applicationID_;
	NSMutableDictionary		*requestsMapping_;
}

@property (nonatomic, readwrite, retain) NSString *applicationID;

@end
