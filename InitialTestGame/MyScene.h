//
//  MyScene.h
//  InitialTestGame
//

//  Copyright (c) 2013 Robotic Elephant. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlayerShip.h"

@interface MyScene : SKScene
{
    PlayerShip* playerShip;
    NSMutableArray *spaceShips;
}

@end
