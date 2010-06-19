//
//  Package.h
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 19.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Bundler : NSObject {
	NSURL *applicationURL;
	NSURL *profileURL;
	NSURL *artworkURL;	
}

@property (nonatomic, copy) NSURL *applicationURL;
@property (nonatomic, copy) NSURL *profileURL;
@property (nonatomic, copy) NSURL *artworkURL;

- (NSData *)buildIpa;

@end
