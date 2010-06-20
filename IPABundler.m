//
//  Package.m
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import "IPABundler.h"


@implementation IPABundler

@synthesize delegate, applicationURL, profileURL, artworkURL;

-(id)initWithDelegate:(NSObject <IPABundlerDelegate> *)theDelegate {
	
	self = [self init];
	
	if (self != nil) {
		self.delegate = theDelegate;
	}
	
	return self;
	
}


-(void)dealloc {
	self.delegate = nil;
	self.applicationURL = nil;
	self.profileURL = nil;
	self.artworkURL = nil;
	[super dealloc];
}



- (void)bundle {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSString *timestamp = [NSString stringWithFormat:@"%d", (long)[[NSDate date] timeIntervalSince1970]];	
	NSString *bundleDirectoryPath = [NSString pathWithComponents:[NSArray arrayWithObjects:NSTemporaryDirectory(), timestamp, nil]];	
	NSString *payloadDirectoryPath = [NSString pathWithComponents:[NSArray arrayWithObjects:bundleDirectoryPath, @"Payload", nil]];	

	NSFileManager *manager = [NSFileManager defaultManager];
		
	@try {
	
		// Create working directory
		[manager createDirectoryAtPath:payloadDirectoryPath withIntermediateDirectories:YES attributes:nil error:NULL];

		// Copy app
		NSString *applicationName = [self.applicationURL lastPathComponent];
		NSURL *applicationDestinationURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", payloadDirectoryPath, applicationName]];		


		[manager copyItemAtURL:self.applicationURL toURL:applicationDestinationURL error:NULL];

		// Copy profile if available
		if (self.profileURL != nil) {			
			
			NSString *profileName = [self.profileURL lastPathComponent];			
			NSURL *profileDestinationURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", bundleDirectoryPath, profileName]];
			[manager copyItemAtURL:self.profileURL toURL:profileDestinationURL error:NULL];
		}

		// Copy artwork if available
		if (self.artworkURL != nil) {					
			NSString *artworkName = @"iTunesArtwork";			
			NSURL *artworkDestinationURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", bundleDirectoryPath, artworkName]];
			[manager copyItemAtURL:self.artworkURL toURL:artworkDestinationURL error:NULL];
		}


		// Zipping


		// Returning data
		//return data
		if ([self.delegate respondsToSelector:@selector(didFinishWithData:)]) {
			[self.delegate didFinishWithData:[NSData new]];
		}
			 
	} @catch (NSException *e) {
		NSLog(@"%@", [e reason]);
		if ([self.delegate respondsToSelector:@selector(didFailWithError:)]) {
			[self.delegate didFailWithError:[NSError errorWithDomain:[e reason] code:0 userInfo:nil]];
		}
	} @finally {
		[manager removeItemAtURL:[NSURL fileURLWithPath:bundleDirectoryPath] error:NULL];
		[pool drain];
	}
}

@end
