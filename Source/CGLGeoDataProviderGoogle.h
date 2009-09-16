//
//  CGLGeoDataProviderGoogle.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.15.
//  Copyright 2009 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGLGeoDataProvider.h"

@interface CGLGeoDataProviderGoogle : CGLGeoDataProvider {
	NSString				*apiKey_;
	NSMutableDictionary		*requestsMapping_;
}

@property (nonatomic, readwrite, retain) NSString *apiKey;

@end
