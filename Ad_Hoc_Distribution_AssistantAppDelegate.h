//
//  Ad_Hoc_Distribution_AssistantAppDelegate.h
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Ad_Hoc_Distribution_AssistantAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)chooseBinary:(id)sender;
-(IBAction)chooseArtwork:(id)sender;
-(IBAction)chooseProfile:(id)sender;
-(IBAction)saveIpa:(id)sender;

@end
