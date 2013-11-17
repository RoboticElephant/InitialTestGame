//
//  AppDelegate.m
//  InitialTestGame
//
//  Created by Joshua Blakely on 11/15/13.
//  Copyright (c) 2013 Robotic Elephant. All rights reserved.
//

#import "AppDelegate.h"
#import "MyScene.h"
//#import <SpriteKit/SpriteKit.h>
#import <ExceptionHandling/ExceptionHandling.h>

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    SKScene *scene = [MyScene sceneWithSize:CGSizeMake(1024, 768)];

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];

    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
	
	//Exception Handling
	[[NSExceptionHandler defaultExceptionHandler] setExceptionHandlingMask:NSLogAndHandleEveryExceptionMask];
	[[NSExceptionHandler defaultExceptionHandler] setDelegate:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (BOOL)exceptionHandler:(NSExceptionHandler *)sender shouldLogException:(NSException *)exception mask:(NSUInteger)aMask
{
	NSLog(@"Fatal Exception: %@", exception);
	while(1);
	return true;
}
- (BOOL)exceptionHandler:(NSExceptionHandler *)sender shouldHandleException:(NSException *)exception mask:(NSUInteger)aMask
{
	NSLog(@"Fatal Exception: %@", exception);
	while(1);
	return true;
}

@end
