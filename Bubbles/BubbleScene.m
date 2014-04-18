//
//  BubbleScene.m
//  Bubbles
//
//  Created by John Watson on 4/16/14.
//  Copyright (c) 2014 John Watson. All rights reserved.
//

#import "BubbleScene.h"
#import "BubbleNode.h"

static inline CGFloat RandomFloat(void)
{
    return rand() / (CGFloat)RAND_MAX;
}

static inline CGFloat GetRandomCoordinate(CGFloat max)
{
    return RandomFloat() * max;
}

@interface BubbleScene ()
@property BOOL contentCreated;
@property (assign) NSColorWell *colorWell;
@end

@implementation BubbleScene

- (instancetype)initWithSize:(CGSize)size colorWell:(NSColorWell*)colorWell
{
    self = [super initWithSize:size];
    
    if(self) {
        self.colorWell = colorWell;
        [colorWell addObserver:self forKeyPath:@"color" options:0 context:NULL];
    }
    
    return self;
}

- (void)dealloc
{
    [self.colorWell removeObserver:self forKeyPath:@"color"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualTo:@"color"] && [object isEqualTo:self.colorWell]) {
        self.backgroundColor = self.colorWell.color;
    }
}

- (void)didMoveToView:(SKView *)view
{
    if(!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = self.colorWell.color;
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    void (^createBubbles)(CGFloat, CGFloat, CGFloat) = ^(CGFloat radius, CGFloat alpha, CGFloat zPosition) {
        const int kBubblesPerType = 5;
        for(int i = 0; i < kBubblesPerType; ++i) {
            BubbleNode *node = [[BubbleNode alloc] initWithRadius:radius alpha:alpha];
            node.name = @"bubble";
            node.position = CGPointMake(GetRandomCoordinate(self.size.width), GetRandomCoordinate(self.size.height));
            node.zPosition = zPosition;
            [self addChild:node];
        }
    };
    
    // Create larger, more opaque bubbles
    createBubbles(100, 0.4, 3);
    
    // Create medium-sized, more translucent bubbles
    createBubbles(50, 0.3, 2);
    
    // Create small, nearly transparent bubbles
    createBubbles(25, 0.2, 1);
    
    // Trigger addRandomBubble selector about every two seconds
    SKAction *addBubbles = [SKAction sequence:@[[SKAction performSelector:@selector(addRandomBubble) onTarget:self], [SKAction waitForDuration:2.0 withRange:0.50]]];
    [self runAction:[SKAction repeatActionForever:addBubbles]];
}

- (void)addRandomBubble
{
    static int index = 0;
    static const CGFloat sizes[] = {100, 50, 25};
    static const CGFloat alphas[] = {0.4, 0.3, 0.2};
    static const CGFloat zPositions[] = {3,2,1};
    
    const CGFloat size = sizes[index];
    const CGFloat alpha = alphas[index];
    const CGFloat zPosition = zPositions[index];
    
    if(++index == 3) {
        index = 0;
    }
    
    BubbleNode *node = [[BubbleNode alloc] initWithRadius:size alpha:alpha];
    node.position = CGPointMake(GetRandomCoordinate(self.size.width), self.size.height + (size * 2));
    node.zPosition = zPosition;
    
    [self addChild:node];
}

- (void)didEvaluateActions
{
    [self enumerateChildNodesWithName:@"bubble" usingBlock:^(SKNode *node, BOOL *stop) {
        if(node.position.y < -100) {
            [node removeFromParent];
        }
    }];
}

@end
