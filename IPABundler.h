//
//  Package.h
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IPABundlerDelegate.h"


@interface IPABundler : NSObject {
	__weak NSObject <IPABundlerDelegate> *delegate;
	NSURL *applicationURL;
	NSURL *profileURL;
	NSURL *artworkURL;	
}

@property (nonatomic, assign) NSObject <IPABundlerDelegate> *delegate;
@property (nonatomic, copy) NSURL *applicationURL;
@property (nonatomic, copy) NSURL *profileURL;
@property (nonatomic, copy) NSURL *artworkURL;

-(id)initWithDelegate:(NSObject <IPABundlerDelegate> *)theDelegate;
- (void)bundle;

@end
