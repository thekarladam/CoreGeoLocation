//
//  CGLGeoDataProviderGoogle.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.15.
//  Copyright 2009 Yahoo. All rights reserved.
//

#import "CGLGeoDataProviderGoogle.h"
#import "CGLGeoRequest.h"
#import "CGLGeoLocation.h"
#import "CGLURLRequestLoader.h"

#import "CGLXML.h"
#import "NSString+CGLURLLoadingAdditions.h"

#import <libxml/parser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>


@interface CGLGeoDataProviderGoogle ()
@property (nonatomic, readwrite, retain) NSMutableDictionary *requestsMapping;

- (CGLGeoLocation *)_geoLocationFromXML:(NSString *)inXMLString;
@end


@implementation CGLGeoDataProviderGoogle

- (id)init {
	if (self = [super init]) {
		self.requestsMapping = [NSMutableDictionary dictionaryWithCapacity:15];
	}
	return self;
}

- (oneway void)dealloc {
	self.apiKey = nil;
	self.requestsMapping = nil;
	
	[super dealloc];
}

@synthesize apiKey = apiKey_;
@synthesize requestsMapping = requestsMapping_;

#pragma mark -

- (BOOL)canHandleRequest:(CGLGeoRequest *)inRequest {
	BOOL canHandleRequest = NO;
	
	
	if ([self.apiKey length]) {
		canHandleRequest = [super canHandleRequest:inRequest];
	}
	
	return canHandleRequest;
}

- (void)performRequest:(CGLGeoRequest *)inRequest {
	NSString *query = nil;
	if ([inRequest address]) {
		query = [inRequest address];
	} else if ([inRequest location]) {
		CLLocationCoordinate2D coordinate = [[inRequest location] coordinate];
		query = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
	}
	
	if (query) {
		NSMutableString *urlString = [NSMutableString stringWithString:@"http://maps.google.com/maps/geo?"];
		
		[urlString appendFormat:@"q=%@&", [query cglEscapedURLEncodedString]];
		[urlString appendFormat:@"key=%@&", [self.apiKey cglEscapedURLEncodedString]];
		[urlString appendString:@"sensor=true&output=xml&oe=utf-8"];
		
		NSURLRequest *loadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
		
		[CGLURLRequestLoader loaderWithRequest:loadRequest target:self action:@selector(loader:loadedData:usingEncoding:)];
		[self.requestsMapping setObject:inRequest forKey:loadRequest];
	}
}

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

- (CGLGeoLocation *)_geoLocationFromXML:(NSString *)inXMLString {
	CGLGeoLocation *geoLocation = nil;
	
	if ([inXMLString length]) {
		const char *xmlCString = [inXMLString UTF8String];
		xmlParserCtxtPtr parserContext = xmlNewParserCtxt();
		xmlDocPtr locationXML = xmlCtxtReadMemory(parserContext, xmlCString, strlen(xmlCString), NULL, NULL, XML_PARSE_NOBLANKS);
		xmlNodePtr rootNode = xmlDocGetRootElement(locationXML);
		xmlNodePtr resultNode = rootNode->children;
		
		NSString *name = nil;
		NSString *latitude = nil;
		NSString *longitude = nil;
		
		if (resultNode) {			
			xmlNodePtr placemarkNode = cgl_xmlNodeGetChildNodeNamed(resultNode, "Placemark");
			xmlNodePtr nameNode = cgl_xmlNodeGetChildNodeNamed(placemarkNode, "address");
			xmlNodePtr pointNode = cgl_xmlNodeGetChildNodeNamed(placemarkNode, "Point");
			xmlNodePtr coordinateNode = cgl_xmlNodeGetChildNodeNamed(pointNode, "coordinates");
			name = [NSString stringWithUTF8String:(const char *)xmlNodeGetContent(nameNode)];
			NSString *coordinates = [NSString stringWithUTF8String:(const char *)xmlNodeGetContent(coordinateNode)];
			NSArray *coordinateParts = [coordinates componentsSeparatedByString:@","];
			latitude = [coordinateParts objectAtIndex:0];
			longitude = [coordinateParts objectAtIndex:1];
			
			if (latitude && longitude) {
				CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
				geoLocation = [[[CGLGeoLocation alloc] initWithName:name andCoreLocation:location] autorelease];
				[location release];
			}			
		}
		
		xmlFreeDoc(locationXML);
		xmlFreeParserCtxt(parserContext);
		xmlCleanupMemory();
	}
	
	return geoLocation;	
}

@end
