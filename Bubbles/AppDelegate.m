//
//  AppDelegate.m
//  Bubbles
//
//  Created by John Watson on 4/16/14.
//  Copyright (c) 2014 John Watson. All rights reserved.
//

#import "AppDelegate.h"

#import "BubbleScene.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    SKView *spriteView = (SKView*)self.spriteView;
    
#ifdef DEBUG
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
#endif
    
    CGSize size = spriteView.frame.size;
    BubbleScene *scene = [[BubbleScene alloc] initWithSize:CGSizeMake(size.width, size.height) colorWell:self.colorWell];
    
    scene.filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputRadiusKey, @5, nil];
    scene.shouldEnableEffects = YES;
    
    [spriteView presentScene:scene];
}

@end
