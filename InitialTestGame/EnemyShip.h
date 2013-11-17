//
//  EnemyShip.h
//  InitialTestGame
//
//  Created by Zack Roman on 11/16/13.
//  Copyright (c) 2013 Robotic Elephant. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface EnemyShip : SKSpriteNode

-(id)initWithImageNamed:(NSString *)name;
-(void)selfDestruct;

@end
