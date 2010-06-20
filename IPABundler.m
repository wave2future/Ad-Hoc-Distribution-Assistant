//
//  Package.m
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import "IPABundler.h"


@implementation IPABundler

@synthesize delegate, applicationURL, profileURL, artworkURL, applicationName;

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
	self.applicationName = nil;
	[super dealloc];
}



- (void)bundle {	
	[NSThread detachNewThreadSelector:@selector(detachedBundleThread) toTarget:self withObject:nil];
}

- (void)detachedBundleThread {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *timestamp = [NSString stringWithFormat:@"%d", (long)[[NSDate date] timeIntervalSince1970]];	
	NSString *bundleDirectoryPath = [NSString pathWithComponents:[NSArray arrayWithObjects:NSTemporaryDirectory(), timestamp, nil]];	
	NSString *payloadDirectoryPath = [NSString pathWithComponents:[NSArray arrayWithObjects:bundleDirectoryPath, @"Payload", nil]];	
	
	NSFileManager *manager = [NSFileManager defaultManager];
	
	@try {
		
		// Create working directory
		[manager createDirectoryAtPath:payloadDirectoryPath withIntermediateDirectories:YES attributes:nil error:NULL];
		
		// Copy app
		self.applicationName = [self.applicationURL lastPathComponent];
		NSURL *applicationDestinationURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", payloadDirectoryPath, self.applicationName]];		
		
		
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
		
		
		// Compressing
		
		NSString *targetPath = [NSString pathWithComponents:[NSArray arrayWithObjects:NSTemporaryDirectory(), [NSString stringWithFormat:@"%@.ipa", timestamp], nil]];		
		
		NSTask *zipTask = [[[NSTask alloc] init] autorelease];
		[zipTask setLaunchPath:@"/usr/bin/ditto"];			
		[zipTask setArguments:[NSArray arrayWithObjects:@"-c", @"-k", @"--sequesterRsrc", bundleDirectoryPath, targetPath, nil]];		
		[zipTask launch];
		[zipTask waitUntilExit];
		
		if ([zipTask terminationStatus] != 0) {
			[self.delegate performSelectorOnMainThread:@selector(didFailWithError:)
											withObject:[NSError errorWithDomain:@"Failed while compressing bundle" code:[zipTask terminationStatus] userInfo:nil]
										 waitUntilDone:NO];		
		}
						
		NSData *ipaArchive = [NSData dataWithContentsOfFile:targetPath];
		
		if ([self.delegate respondsToSelector:@selector(didFinishWithData:)]) {			
			[self.delegate performSelectorOnMainThread:@selector(didFinishWithData:)
											withObject:ipaArchive
										 waitUntilDone:NO];			
		}
			
	} @catch (NSException *e) {
		NSLog(@"%@", [e reason]);
		if ([self.delegate respondsToSelector:@selector(didFailWithError:)]) {
			[self.delegate performSelectorOnMainThread:@selector(didFailWithError:)
											withObject:[NSError errorWithDomain:[e reason] code:0 userInfo:nil]
										 waitUntilDone:NO];		
		}
	} @finally {
		[manager removeItemAtURL:[NSURL fileURLWithPath:bundleDirectoryPath] error:NULL];
		[pool drain];
	}
}

@end
