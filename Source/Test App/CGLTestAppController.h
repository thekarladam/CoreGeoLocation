//
//  CGLTestAppController.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.12.
//  Copyright 2009 Yahoo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreGeoLocation/CoreGeoLocation.h>

@class CGLGeoRequest;

@interface CGLTestAppController : NSObject <CGLGeoManagerDelegate> {
	IBOutlet NSTextField			*locationTextField;
	IBOutlet NSTextField			*latitudeTextField;
	IBOutlet NSTextField			*longitudeTextField;
	IBOutlet NSTextView				*outputTextView;
	IBOutlet NSProgressIndicator	*progressIndicator;
	
			CGLGeoRequest			*currentGeoRequest;
}

@property (nonatomic, readwrite, retain) CGLGeoRequest *currentGeoRequest;

- (IBAction)lookup:(id)sender;

@end
