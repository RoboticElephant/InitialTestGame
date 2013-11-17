//
//  PlayerShip.h
//  GameTest01
//
//  Created by Zack Roman on 11/15/13.
//  Copyright (c) 2013 Zack Roman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PlayerShip : SKSpriteNode

-(id)initWithImageNamed:(NSString *)name;
-(void)fireLasers;

@end
