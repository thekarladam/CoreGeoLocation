//
//  CGLURLRequestLoader.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import "CGLURLRequestLoader.h"
#import "NSURLResponse+CGLEncodingAdditions.h"

@interface CGLURLRequestLoader ()
@property (nonatomic, readwrite, retain) NSURLRequest *urlRequest;
@property (nonatomic, readwrite, retain) NSURLResponse *urlResponse;
@property (nonatomic, readwrite, retain) NSURLConnection *urlConnection;
@property (nonatomic, readwrite, assign) NSStringEncoding responseEncoding;
@property (nonatomic, readwrite, retain) NSMutableData *data;

@end

@implementation CGLURLRequestLoader

+ (CGLURLRequestLoader *)loaderWithRequest:(NSURLRequest *)inRequest target:(id)inTarget action:(SEL)inSelector {
	return [[[self alloc] initWithRequest:inRequest target:inTarget action:inSelector] autorelease];
}

- (id)initWithRequest:(NSURLRequest *)inRequest target:(id)inTarget action:(SEL)inAction {
	if (self = [super init]) {
		self.target = inTarget;
		self.action = inAction;
		self.data = [NSMutableData data];
		self.urlRequest = inRequest;
		[NSURLConnection connectionWithRequest:inRequest delegate:self];
	}
	
	return self;
}

- (oneway void)dealloc {
	self.urlRequest = nil;
	self.urlResponse = nil;
	self.urlConnection = nil;
	self.data = nil;
	
	[super dealloc];
}

@synthesize urlRequest = urlRequest_;
@synthesize urlResponse = urlResponse_;
@synthesize urlConnection = urlConnection_;
@synthesize responseEncoding = responseEncoding_;
@synthesize data = data_;
@synthesize target = target_;
@synthesize action = selector_;

#pragma mark -

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	self.urlResponse = response;
	self.responseEncoding = [response cglEncoding];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	NSMethodSignature *methodSignature = [self.target methodSignatureForSelector:self.action];
	if (methodSignature) {
		NSInvocation *anInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
		[anInvocation setTarget:self.target];
		[anInvocation setSelector:self.action];
		[anInvocation setArgument:&self atIndex:2];
		[anInvocation setArgument:&data_ atIndex:3];
		[anInvocation setArgument:&responseEncoding_ atIndex:4];
		[anInvocation retainArguments];
		
		[anInvocation invoke];
	}
}

@end
