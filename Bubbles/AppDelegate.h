//
//  AppDelegate.h
//  Bubbles
//
//  Created by John Watson on 4/16/14.
//  Copyright (c) 2014 John Watson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSView *spriteView;
@property (weak) IBOutlet NSColorWell *colorWell;

@end
