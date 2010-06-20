//
//  IPABundlerDelegate.h
//  Ad Hoc Distribution Assistant
//
//  Created by Yves Vogl on 20.06.10.
//  Copyright 2010 DEETUNE. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol IPABundlerDelegate

-(void)didFinishWithData:(NSData *)IPABundleData;

@optional

-(void)didFailWithError:(NSError *)error;


@end
