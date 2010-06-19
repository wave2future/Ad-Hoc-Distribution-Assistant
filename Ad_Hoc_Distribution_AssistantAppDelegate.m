//
//  Ad_Hoc_Distribution_AssistantAppDelegate.m
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import "Ad_Hoc_Distribution_AssistantAppDelegate.h"

@implementation Ad_Hoc_Distribution_AssistantAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSSize windowSize = [self.window frame].size;
	[self.window setAspectRatio:windowSize];
}

-(IBAction)chooseBinary:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:NO];
	[panel setAllowedFileTypes:[NSArray arrayWithObject:@"app"]];
	[panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result ==  NSFileHandlingPanelOKButton) {

		}
	}];
}


-(IBAction)chooseArtwork:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:NO];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects:@"png", @"jpg", @"jpeg", @"tiff", @"tif", nil]];
	[panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result ==  NSFileHandlingPanelOKButton) {
			
		}
	}];
}

-(IBAction)chooseProfile:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:NO];
	[panel setAllowedFileTypes:[NSArray arrayWithObject:@"mobileprovision"]];
	[panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result ==  NSFileHandlingPanelOKButton) {
			
		}
	}];
}

-(IBAction)saveIpa:(id)sender {
}




@end
