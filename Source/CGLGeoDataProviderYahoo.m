//
//  CGLGeoDataProviderYahoo.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import "CGLGeoDataProviderYahoo.h"
#import "CGLURLRequestLoader.h"
#import "CGLGeoRequest.h"
#import "CGLGeoLocation.h"
#import "NSString+CGLURLLoadingAdditions.h"

#import <libxml/parser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

@interface CGLGeoDataProviderYahoo ()
@property (nonatomic, readwrite, retain) NSMutableDictionary *requestsMapping;

- (void)_performRequestUsingAddress:(CGLGeoRequest *)inRequest;
- (CGLGeoLocation *)_geoLocationFromXML:(NSString *)inXMLString;
- (void)_performRequestUsingLatitudeAndLongitude:(CGLGeoRequest *)inRequest;
@end

@implementation CGLGeoDataProviderYahoo

+ (BOOL)canHandleRequest:(CGLGeoRequest *)inRequest {
	BOOL canHandleRequest = [super canHandleRequest:inRequest];
	
	if ([inRequest address]) {
		canHandleRequest = YES;
	}
	
	return canHandleRequest;
}

- (id)init {
	if (self = [super init]) {
		self.requestsMapping = [NSMutableDictionary dictionaryWithCapacity:15];
	}
	return self;
}

- (oneway void)dealloc {
	self.applicationID = nil;
	self.requestsMapping = nil;
	
	[super dealloc];
}

@synthesize applicationID = applicationID_;
@synthesize requestsMapping = requestsMapping_;

#pragma mark -

- (BOOL)canHandleRequest:(CGLGeoRequest *)inRequest {
	BOOL canHandleRequest = NO;
	
	
	if ([self.applicationID length]) {
		canHandleRequest = [super canHandleRequest:inRequest];
	}
	
	return canHandleRequest;
}

- (void)performRequest:(CGLGeoRequest *)inRequest {
	if ([inRequest address]) {
		[self _performRequestUsingAddress:inRequest];
	} else {
		[self _performRequestUsingLatitudeAndLongitude:inRequest];
	}
}

- (void)_performRequestUsingAddress:(CGLGeoRequest *)inRequest {
	NSMutableString *urlString = [NSMutableString stringWithString:@"http://local.yahooapis.com/MapsService/V1/geocode?"];
	
	[urlString appendFormat:@"appid=%@&", [self.applicationID cglEscapedURLEncodedString]];
	[urlString appendFormat:@"location=%@&", [inRequest.address cglEscapedURLEncodedString]];
	
	NSURLRequest *loadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	
	[CGLURLRequestLoader loaderWithRequest:loadRequest target:self action:@selector(loader:loadedData:usingEncoding:)];
	[self.requestsMapping setObject:inRequest forKey:loadRequest];
}

- (void)_performRequestUsingLatitudeAndLongitude:(CGLGeoRequest *)inRequest {
	[NSException raise:@"Net Yet Implemented" format:@"Please Implement Me"];
}

- (CGLGeoLocation *)_geoLocationFromXML:(NSString *)inXMLString {
	CGLGeoLocation *geoLocation = nil;
	
	if ([inXMLString length]) {
		const char *xmlCString = [inXMLString UTF8String];
		xmlParserCtxtPtr parserContext = xmlNewParserCtxt();
		xmlDocPtr locationXML = xmlCtxtReadMemory(parserContext, xmlCString, strlen(xmlCString), NULL, NULL, XML_PARSE_NOBLANKS);
		xmlNodePtr rootNode = xmlDocGetRootElement(locationXML);
		xmlNodePtr resultNode = rootNode->children;
		const char *currentNodeName = NULL;
		
		NSString *latitude = nil;
		NSString *longitude = nil;
		NSString *address = nil;
		NSString *city = nil;
		NSString *state = nil;
		NSString *zip = nil;
		NSString *country = nil;
		
		if (resultNode) {
			// we only process the first Result
			xmlNodePtr currentNode = resultNode->children;
			
			for ( ; currentNode; currentNode = currentNode->next) {
				currentNodeName = (const char *)currentNode->name;
				if (strcmp("Latitude", currentNodeName) == 0) {
					latitude = [NSString stringWithCString:(const char *)xmlNodeGetContent(currentNode) encoding:NSUTF8StringEncoding];
				} else if (strcmp("Longitude", currentNodeName) == 0) {
					longitude = [NSString stringWithCString:(const char *)xmlNodeGetContent(currentNode) encoding:NSUTF8StringEncoding];
				} else if (strcmp("Address", currentNodeName) == 0) {
					address = [NSString stringWithCString:(const char *)xmlNodeGetContent(currentNode) encoding:NSUTF8StringEncoding];
				} else if (strcmp("City", currentNodeName) == 0) {
					city = [NSString stringWithCString:(const char *)xmlNodeGetContent(currentNode) encoding:NSUTF8StringEncoding];
				} else if (strcmp("State", currentNodeName) == 0) {
					state = [NSString stringWithCString:(const char *)xmlNodeGetContent(currentNode) encoding:NSUTF8StringEncoding];
				} else if (strcmp("Zip", currentNodeName) == 0) {
					zip = [NSString stringWithCString:(const char *)xmlNodeGetContent(currentNode) encoding:NSUTF8StringEncoding];
				} else if (strcmp("Country", currentNodeName) == 0) {
					country = [NSString stringWithCString:(const char *)xmlNodeGetContent(currentNode) encoding:NSUTF8StringEncoding];
				}				
			}
			if (latitude && longitude) {
				CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
				geoLocation = [[[CGLGeoLocation alloc] initWithAddress:address city:city state:state zip:zip country:country andCoreLocation:location] autorelease];
				[location release];
			}			
		}
		
		xmlFreeDoc(locationXML);
		xmlFreeParserCtxt(parserContext);
		xmlCleanupMemory();
	}
	
	return geoLocation;
}

#pragma mark -

- (void)loader:(CGLURLRequestLoader *)inLoader loadedData:(NSData *)inData usingEncoding:(NSStringEncoding)inEncoding {
	CGLGeoLocation *geoLocation = nil;
	NSString *responseString = [[NSString alloc] initWithData:inData encoding:inEncoding];
	
	if (responseString) {
		NSLog(@"responseString: %@", responseString);
		geoLocation = [self _geoLocationFromXML:responseString];
	}
	
	[self.delegate geoLocation:geoLocation determinedForRequest:[self.requestsMapping objectForKey:[inLoader urlRequest]]];
	[self.requestsMapping removeObjectForKey:[inLoader urlRequest]];

	[responseString release];
}

@end
