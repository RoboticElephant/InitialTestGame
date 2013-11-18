 //
//  MyScene.m
//  InitialTestGame
//
//  Created by Joshua Blakely on 11/15/13.
//  Copyright (c) 2013 Robotic Elephant. All rights reserved.
//

#import "MyScene.h"
#import "PlayerShip.h"
#import "SharedDefs.h"
#import "EnemyShip.h"

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

KeyArgs keyArgs;
BOOL bFireLasers;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
		playerShip = [[PlayerShip alloc] initWithImageNamed:@"PLANE1"];
        playerShip.position = CGPointMake(CGRectGetMidX(self.frame), (self.frame.size.height / 4.0));
        playerShip.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[playerShip size]];
        playerShip.physicsBody.allowsRotation = NO;
        
        //        sprite.physicsBody.dynamic = YES;
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
		self.physicsWorld.contactDelegate = self;
        [self addChild:playerShip];
    }
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
	
	EnemyShip* ship = [[EnemyShip alloc] initWithImageNamed:@"Spaceship"];
	
	ship.position = location;
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    [ship runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:ship];
}

-(void)rightMouseDown:(NSEvent *)theEvent
{
    /* Called when a right mouse click occurs */
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
	
	if(bFireLasers)
	{
		[playerShip fireLasers];
		bFireLasers = false;
	}
	
	[playerShip runAction:sequence];
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
	EnemyShip* ship = NULL;
	SKNode *laser = NULL;
	
	//NSLog(@"Collision A: %d, B: %d", )
	
	switch(contact.bodyA.categoryBitMask)
	{
		case kShipCategory:	ship = (EnemyShip*)contact.bodyA.node; break;
		case kLaserCategory: laser = contact.bodyA.node; break;
	}
	switch(contact.bodyB.categoryBitMask)
	{
		case kShipCategory:	ship = (EnemyShip*)contact.bodyB.node; break;
		case kLaserCategory: laser = contact.bodyB.node; break;
	}
	
	if(ship != NULL && laser != NULL)
	{
		//[SKAction ]
		//[SKAction runAction:[SKAction removeFromParent] onChildWithName:@"laserfire"];
		[laser removeAllChildren];
		[laser removeFromParent];
		[ship selfDestruct];
	}
}

@end
