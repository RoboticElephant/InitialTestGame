//
//  EnemyShip.m
//  InitialTestGame
//
//  Created by Zack Roman on 11/16/13.
//  Copyright (c) 2013 Robotic Elephant. All rights reserved.
//

#import "EnemyShip.h"
#import "SharedDefs.h"


@implementation EnemyShip

bool bIsDestroyed;

-(id)initWithImageNamed:(NSString *)name
{
	self = [super initWithImageNamed:name];
	if(self)
	{
		self.scale = 0.25;
		self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[self size]];
		self.physicsBody.categoryBitMask = kShipCategory;
		self.physicsBody.contactTestBitMask = kLaserCategory;


		bIsDestroyed = false;
	}
	
	return self;
}

-(void)selfDestruct
{
	if(!bIsDestroyed)
	{
		bIsDestroyed = true;
		
		NSString *explosionParticlePath = [[NSBundle mainBundle] pathForResource:@"ShipExplosion" ofType:@"sks"];
		SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionParticlePath];
		explosion.name = @"explosion";
		
		//self.physicsBody.collisionBitMask = 0;	//optionally turn off collisions with everything else
		
		SKAction* explosionSeqeunce = [SKAction sequence:@[
			[SKAction fadeInWithDuration:0.2],
			[SKAction waitForDuration:0.4],
			[SKAction fadeOutWithDuration:.02],
			[SKAction removeFromParent]
		]];
		
		SKAction* shipSequence = [SKAction sequence:@[
			[SKAction fadeOutWithDuration:0.5],
			[SKAction waitForDuration:1.0],
			[SKAction removeFromParent]
		]];
		
		[self addChild:explosion];
		[explosion runAction:explosionSeqeunce];
		
		[self runAction:shipSequence];
	}
}

@end
