//
//  Ad_Hoc_Distribution_AssistantAppDelegate.h
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IPABundler.h"
#import "ProgressSheet.h"

@interface Ad_Hoc_Distribution_AssistantAppDelegate : NSObject <NSApplicationDelegate, IPABundlerDelegate> {
    NSWindow *window;
	IPABundler *ipaBundler;
	NSImageView *artworkImageView;
	NSMenuItem *saveMenuItem;
	NSButton *saveButton;	
	ProgressSheet *progressSheet;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IPABundler *ipaBundler;
@property (assign) IBOutlet NSImageView *artworkImageView;
@property (assign) IBOutlet NSMenuItem *saveMenuItem;
@property (assign) IBOutlet NSButton *saveButton;
@property (assign) IBOutlet ProgressSheet *progressSheet;

-(IBAction)chooseBinary:(id)sender;
-(IBAction)chooseArtwork:(id)sender;
-(IBAction)chooseProfile:(id)sender;
-(IBAction)saveIpa:(id)sender;

@end
