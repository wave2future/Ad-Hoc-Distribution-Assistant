//
//  ProgressView.h
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 20.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ProgressSheet : NSWindow {
	IBOutlet NSTextField *label;
	IBOutlet NSProgressIndicator *progressIndicator;
}

@property (nonatomic, assign) NSTextField *label;
@property (nonatomic, assign) NSProgressIndicator *progressIndicator;

@end
