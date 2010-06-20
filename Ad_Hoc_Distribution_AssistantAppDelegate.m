//
//  Ad_Hoc_Distribution_AssistantAppDelegate.m
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import "Ad_Hoc_Distribution_AssistantAppDelegate.h"

@implementation Ad_Hoc_Distribution_AssistantAppDelegate

@synthesize window, ipaBundler, artworkImageView, saveMenuItem, saveButton, progressSheet;


- (id)init {
	
	self = [super init];
	
	if (self != nil) {
		self.ipaBundler = [[IPABundler alloc] initWithDelegate:self];
	}
	
	return self;
}

- (void)dealloc {
	[self.ipaBundler release];	
	[super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSSize windowSize = [self.window frame].size;
	[self.window setAspectRatio:windowSize];
	
	[self.saveMenuItem setEnabled:NO];
	[self.saveButton setEnabled:NO];
}

-(void)windowWillClose:(NSNotification *)notification {
	[NSApp terminate:self.window];
}


-(IBAction)chooseBinary:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:NO];
	[panel setAllowedFileTypes:[NSArray arrayWithObject:@"app"]];
	[panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result ==  NSFileHandlingPanelOKButton) {
			self.ipaBundler.applicationURL = [[panel URLs] lastObject];
			[self.saveButton setEnabled:YES];
			[self.saveMenuItem setEnabled:YES];
		}
	}];
}


-(IBAction)chooseArtwork:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:NO];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects:@"png", nil]];
	[panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result ==  NSFileHandlingPanelOKButton) {			
			self.ipaBundler.artworkURL = [[panel URLs] lastObject];
						
			NSImage *image = [[NSImage alloc] initWithContentsOfURL:self.ipaBundler.artworkURL];
			[self.artworkImageView setImage:image];
			[image release];
		}
	}];
}

-(IBAction)chooseProfile:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:NO];
	[panel setAllowedFileTypes:[NSArray arrayWithObject:@"mobileprovision"]];
	[panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result ==  NSFileHandlingPanelOKButton) {
			self.ipaBundler.profileURL = [[panel URLs] lastObject];
		}
	}];
}

-(IBAction)saveIpa:(id)sender {
	[NSApp beginSheet:self.progressSheet modalForWindow:self.window modalDelegate:self didEndSelector:NULL contextInfo:nil];	
	[self.progressSheet.progressIndicator startAnimation:self];
	[self.ipaBundler bundle];
}

#pragma mark IPABundler delegates

-(void)didFinishWithData:(NSData *)IPABundleData {
	[self.progressSheet close];
	[NSApp endSheet:self.progressSheet];
	
	NSSavePanel *panel = [NSSavePanel savePanel];
	[panel setAllowedFileTypes:[NSArray arrayWithObject:@"ipa"]];
	[panel setCanCreateDirectories:YES];
	[panel setCanSelectHiddenExtension:YES];
	[panel setExtensionHidden:NO];
	
	NSString *documentsDirectory;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	if ([paths count] > 0)  {
		documentsDirectory = [paths objectAtIndex:0];
	}	
	[panel setDirectoryURL:[NSURL fileURLWithPath:documentsDirectory]];
	[panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result ==  NSFileHandlingPanelOKButton) {
			
			NSError *error;			
			
			if (![IPABundleData writeToURL:[panel URL] options:NSDataWritingAtomic error:&error]) {
				[self didFailWithError:error];
			}			
		}
	}];
}

-(void)didFailWithError:(NSError *)error {
	
	[NSApp endSheet:self.progressSheet];
	
	[[NSAlert alertWithMessageText:@"Sorry" 
					defaultButton:@"OK" 
				  alternateButton:nil 
					  otherButton:nil 
		informativeTextWithFormat:[error localizedDescription]] runModal];
	
}

@end
