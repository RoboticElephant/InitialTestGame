//
//  PlayerShip.m
//  GameTest01
//
//  Created by Zack Roman on 11/15/13.
//  Copyright (c) 2013 Zack Roman. All rights reserved.
//

#import "PlayerShip.h"
#import "SharedDefs.h"

@implementation PlayerShip

-(id)initWithImageNamed:(NSString *)name
{
	//self = [super initWithImageNamed:@"Spaceship"];
	self = [super initWithImageNamed:name];
	if(self)
	{
		self.scale = 0.5;
		self.physicsBody.categoryBitMask = kShipCategory;
	}
	
	return self;
}

-(void)fireLasers
{
	const int RADIUS = 7;
	SKShapeNode* laser1 = [[SKShapeNode alloc] init];
	CGMutablePathRef myPath = CGPathCreateMutable();
	CGPathAddArc(myPath, NULL, 0,0, RADIUS, 0, M_PI*2, YES);
	laser1.path = myPath;
	
	laser1.lineWidth = 1.0;
	laser1.fillColor = [SKColor yellowColor];
	laser1.strokeColor = [SKColor whiteColor];
	laser1.glowWidth = 0.5;
	
	NSString *laserParticlePath = [[NSBundle mainBundle] pathForResource:@"LaserParticle" ofType:@"sks"];
	SKEmitterNode *laserFire = [NSKeyedUnarchiver unarchiveObjectWithFile:laserParticlePath];
	laserFire.name = @"laserfire";
	[laser1 addChild:laserFire];
	
	SKAction* s1 = [SKAction moveByX:0 y:1000 duration:1.0];
	SKAction* s2 = [SKAction runAction:[SKAction removeFromParent] onChildWithName:@"laserfire"];
	SKAction* s3 = [SKAction removeFromParent];
	
	SKAction* sequence = [SKAction sequence:@[s1, s2, s3]];
	[laser1 runAction:sequence];
	
	laser1.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:RADIUS];
	laser1.physicsBody.categoryBitMask = kLaserCategory;
	laser1.physicsBody.contactTestBitMask = kShipCategory;

	//copy to loaser 2
	SKShapeNode* laser2 = [laser1 copy];
	
	
	laser1.position = CGPointMake(self.position.x - 20, self.position.y+15);
	laser2.position = CGPointMake(self.position.x + 20, self.position.y+15);
	
	NSLog(@"Fire Position (%f, %f)", self.position.x, self.position.y);
	
	[self.parent addChild:laser1];
	[self.parent addChild:laser2];
}

@end
