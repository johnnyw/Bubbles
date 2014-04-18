//
//  BubbleNode.m
//  Bubbles
//
//  Created by John Watson on 4/17/14.
//  Copyright (c) 2014 John Watson. All rights reserved.
//

#import "BubbleNode.h"

@implementation BubbleNode

- (instancetype)initWithRadius:(CGFloat)radius alpha:(CGFloat)alpha
{
    self = [super init];
    if(self) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, NULL, 0, 0, radius, 0, M_PI * 2, YES);
        self.path = path;
        self.fillColor = [SKColor colorWithWhite:1.0 alpha:alpha];
        self.strokeColor = [SKColor clearColor];
        
        SKAction *fallAction = [SKAction moveByX:0 y:-20 duration:1.0];
        [self runAction:[SKAction repeatActionForever:fallAction]];
        self.name = @"bubble";
    }
    return self;
}

@end
