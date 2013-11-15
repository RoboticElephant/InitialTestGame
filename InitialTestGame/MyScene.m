//
//  MyScene.m
//  InitialTestGame
//
//  Created by Joshua Blakely on 11/15/13.
//  Copyright (c) 2013 Robotic Elephant. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

typedef enum
{
	kNothing = 1 << 0,
	kMoveLeft = 1 << 1,
	kMoveRight = 1 << 2,
	kMoveUp = 1 << 3,
	kMoveDown = 1 << 4,
	kSpace = 1 << 5
} KeyArgs;

NSMutableArray *removeableShips;
KeyArgs keyArgs;
BOOL bFireLasers;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        spaceShips = [[NSMutableArray alloc] init];
        removeableShips = [[NSMutableArray alloc] init];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"PLANE1"];
        
        sprite.position = CGPointMake(CGRectGetMidX(self.frame), (self.frame.size.height / 4.0));
        sprite.scale = 0.5;
        sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[sprite size]];
        sprite.physicsBody.allowsRotation = NO;
        
        //        sprite.physicsBody.dynamic = YES;
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        [spaceShips addObject:sprite];
        [self addChild:sprite];
    }
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    sprite.position = location;
    sprite.scale = 0.25;
    sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[sprite size]];
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:sprite];
    [spaceShips addObject:sprite];
}

-(void)keyDown:(NSEvent *)theEvent
{
    switch ([theEvent keyCode])
	{
		case 0: keyArgs |= kMoveLeft; break;	//Left		'A'
		case 1: keyArgs |= kMoveDown; break;	//Down		'S'
		case 2: keyArgs |= kMoveRight; break;	//Right		'D'
		case 13: keyArgs |= kMoveUp; break;		//Up		'W'
	}
}

-(void)keyUp:(NSEvent *)theEvent
{
	//record when a key is lifted, remove from keypress buffer
	switch ([theEvent keyCode])
	{
		case 0: keyArgs &= ~kMoveLeft; break;	//Left
		case 1: keyArgs &= ~kMoveDown; break;	//Down
		case 2: keyArgs &= ~kMoveRight; break;	//Right
		case 13: keyArgs &= ~kMoveUp; break;	//Up
		case 49: bFireLasers = true; break;		//Space
	}
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    CGSize screenSize = self.frame.size;
    const int moveSize = 10;
	
	NSMutableArray* listActions = [NSMutableArray array];  //autoreleased?
	
	if(keyArgs & kMoveLeft)
	{
        SKAction* moveAction = [SKAction moveByX: -moveSize y: 0 duration: 0.5];
        [listActions addObject:moveAction];
	}
	if(keyArgs & kMoveRight)
	{
        SKAction* moveAction = [SKAction moveByX: moveSize y: 0 duration: 0.5];
        [listActions addObject:moveAction];
	}
	if(keyArgs & kMoveDown)
	{
        SKAction* moveAction = [SKAction moveByX: 0 y: -moveSize duration: 0.5];
        [listActions addObject:moveAction];
	}
	if(keyArgs & kMoveUp)
	{
		SKAction* moveAction = [SKAction moveByX: 0 y: moveSize duration: 0.5];
		[listActions addObject:moveAction];
	}
	
	SKAction* sequence = [SKAction group:listActions];
	
	[[spaceShips objectAtIndex:0] runAction:sequence];
    
    for(SKSpriteNode *inSpace in spaceShips)
    {
        if ([spaceShips indexOfObject:inSpace] != 0)
        {
            if(inSpace.position.y <= screenSize.height)
            {
                [inSpace runAction:[SKAction moveByX:0.0 y: 5.0 duration:0.5]];
                
            } else
            {
                [inSpace removeFromParent];
                [removeableShips addObject:[NSNumber numberWithInteger:[spaceShips indexOfObject:inSpace]]];
            }
        }
    }
    
    for(NSNumber *numb in removeableShips)
    {
        [spaceShips removeObjectAtIndex:[numb integerValue]];
    }
    
    [removeableShips removeAllObjects];
}

@end
