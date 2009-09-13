
#import <Foundation/Foundation.h>

@interface CGLGeocoder : NSObject {
	// Request Parameters
	NSString *appid;
	NSString *street;
	NSString *city;
	NSString *state;
	NSString *zip;
	NSString *location;

	// Result Values
	NSNumber *latitude;
	NSNumber *longitude;
}

@property (nonatomic, retain) NSString *appid;
@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

- (BOOL)geocode;
- (NSString *)encodeString:(NSString*)string;

@end
