//
//  Package.m
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import "Bundler.h"


@implementation Bundler

@synthesize applicationURL, profileURL, artworkURL;


-(void)dealloc {
	self.applicationURL = nil;
	self.profileURL = nil;
	self.artworkURL = nil;
	[super dealloc];
}



- (NSData *)buildIpa {
	
	NSString *timestamp = [NSString stringWithFormat:@"%d", (long)[[NSDate date] timeIntervalSince1970]];
	
	NSString *bundleDirectoryPath = [NSString pathWithComponents:[NSArray arrayWithObjects:NSTemporaryDirectory(), timestamp, nil]];	
	NSString *payloadDirectoryPath = [NSString pathWithComponents:[NSArray arrayWithObjects:bundleDirectoryPath, @"Payload", nil]];		
	
	NSFileManager *manager = [NSFileManager defaultManager];
	NSError *error;
	
	@try {
		
		// Build working directory
		if (![manager createDirectoryAtPath:payloadDirectoryPath 
				withIntermediateDirectories:YES
								 attributes:nil 
									  error:&error]) {		
			
			
		}
		
		NSLog(@"Created working directory at %@", bundleDirectoryPath);
				
		if (![manager copyItemAtURL:self.applicationURL toURL:[NSURL URLWithString:[payloadDirectoryPath stringByAppendingPathComponent:[self.applicationURL lastPathComponent]]] error:&error]) {		
			NSLog(@"%@", error);
		}
		
		if (![manager copyItemAtURL:self.profileURL toURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Distribution.mobileprovision", bundleDirectoryPath]] error:&error]) {		
			
		}
		
		if (![manager copyItemAtURL:self.artworkURL toURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@iTunesArtwork", bundleDirectoryPath]] error:&error]) {		

		}
		
		//[self.applicationURL lastPathComponent] == Bundle name ohne Extension
	}
	@catch (NSException * e) {
		// TODO: Error handling
	}
	@finally {
		// TODO: Cleanup
	}
	

	

	
	return nil;
}

@end
