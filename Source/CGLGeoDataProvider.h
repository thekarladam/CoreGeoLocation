//
//  CGLGeoDataProvider.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import <Foundation/Foundation.h>

@class CGLGeoLocation;
@class CGLGeoRequest;

@protocol CGLGeoDataProviderDelegate;

@interface CGLGeoDataProvider : NSObject {
	id <CGLGeoDataProviderDelegate> delegate_;
}

@property (nonatomic, readwrite, assign) id <CGLGeoDataProviderDelegate> delegate;

+ (BOOL)canHandleRequest:(CGLGeoRequest *)inRequest;

- (BOOL)canHandleRequest:(CGLGeoRequest *)inRequest;
- (void)performRequest:(CGLGeoRequest *)inRequest;

@end

@protocol CGLGeoDataProviderDelegate <NSObject>
- (void)geoLocation:(CGLGeoLocation *)inGeoLocation determinedForRequest:(CGLGeoRequest *)inRequest;
@end