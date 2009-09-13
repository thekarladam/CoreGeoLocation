//
//  CGLURLRequestLoader.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import <Foundation/FOundation.h>

// A Private Implementaion Detail to get around the stupid limitations of NSURLConnection

@interface CGLURLRequestLoader : NSObject {
	NSURLRequest		*urlRequest_;
	NSURLResponse		*urlResponse_;
	NSURLConnection		*urlConnection_;
	NSStringEncoding	responseEncoding_;
	NSMutableData		*data_;
	
	id					target_;
	SEL					selector_;
}

@property (nonatomic, readonly, retain) NSURLRequest *urlRequest;
@property (nonatomic, readonly, retain) NSURLResponse *urlResponse;
@property (nonatomic, readonly, retain) NSURLConnection *urlConnection;
@property (nonatomic, readonly, assign) NSStringEncoding responseEncoding;
@property (nonatomic, readonly, retain) NSMutableData *data;
@property (nonatomic, readwrite, assign) id target;
@property (nonatomic, readwrite, assign) SEL action;


+ (CGLURLRequestLoader *)loaderWithRequest:(NSURLRequest *)inRequest target:(id)inTarget action:(SEL)inSelector;
- (id)initWithRequest:(NSURLRequest *)inRequest target:(id)inTarget action:(SEL)inSelector;

@end
