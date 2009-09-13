
#import "CGLGeocoder.h"


@implementation CGLGeocoder

@synthesize appid;
@synthesize street;
@synthesize city;
@synthesize state;
@synthesize zip;
@synthesize location;
@synthesize latitude;
@synthesize longitude;

- (void)dealloc {
	self.appid = nil;
	self.street = nil;
	self.city = nil;
	self.state = nil;
	self.zip = nil;
	self.location = nil;
	self.latitude = nil;
	self.longitude = nil;
		
	[super dealloc];
}

- (BOOL)geocode {
	NSMutableString *strURL = [NSMutableString stringWithString:@"http://local.yahooapis.com/MapsService/V1/geocode?"];
	
	[strURL appendFormat:@"appid=%@&", [self encodeString:self.appid]];
	
	if(self.street)
		[strURL appendFormat:@"street=%@&", [self encodeString:self.street]];

	if(self.city)
		[strURL appendFormat:@"city=%@&", [self encodeString:self.city]];
	
	if(self.street)
		[strURL appendFormat:@"state=%@&", [self encodeString:self.street]];
	
	if(self.zip)
		[strURL appendFormat:@"zip=%@&", [self encodeString:self.zip]];
	
	if(self.location)
		[strURL appendFormat:@"location=%@&", [self encodeString:self.location]];

//	NSURL *URL = [NSURL URLWithString:strURL];
//	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//	NSData *data = [NSURLConnection sendSynchronousRequest:request
//										 returningResponse:nil
//													 error:nil];
//
//	NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

//	NSXMLDocument *xml = [[NSXMLDocument alloc] initWithXMLString:response options:NSXMLDocumentTidyXML error:nil];
//	
//	NSArray *lat = [xml nodesForXPath:@".//Result/Latitude" error:nil];
//	NSArray *lng = [xml nodesForXPath:@".//Result/Longitude" error:nil];
//
//	if([lat count] == 1 && [lng count] == 1) {
//		self.latitude = [NSNumber numberWithFloat:[[[lat objectAtIndex:0] stringValue] floatValue]];
//		self.longitude = [NSNumber numberWithFloat:[[[lng objectAtIndex:0] stringValue] floatValue]];
//		return YES;
//	}
//	else {
//		self.latitude = nil;
//		self.longitude = nil;
//		return NO;
//	}
	
	return NO;
}

// Stolen from Steven Degutis, who stole it from Matt Gemmell...
- (NSString *)encodeString:(NSString*)string {
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
																		   (CFStringRef)string,
																		   NULL,
																		   (CFStringRef)@";/?:@&=$+{}<>,",
																		   kCFStringEncodingUTF8);
    return [result autorelease];
}

@end
