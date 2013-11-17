//
//  AppDelegate.h
//  InitialTestGame
//

//  Copyright (c) 2013 Robotic Elephant. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>
#import <ExceptionHandling/ExceptionHandling.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet SKView *skView;

//- (BOOL)exceptionHandler:(NSExceptionHandler *)sender shouldHandleException:(NSException *)exception mask:(NSUInteger)aMask;
//- (BOOL)exceptionHandler:(NSExceptionHandler *)sender shouldLogException:(NSException *)exception mask:(NSUInteger)aMask;

@end
