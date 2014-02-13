//  15 PUZZLE
//  PROJECT 2
//  CS470 - Spring 2014
//
//  CREATED BY DAVID WELLS
//  Copyright (c) 2014 David Wells. All rights reserved.
//  All code not provided by Professor Kooshesh is the sole work of David Wells for CS470 at Sonoma State University.

#import <Foundation/Foundation.h>

@interface gameModel : NSObject

/*
 You have to use a model -- an Objective-C class in addition to the ViewController (i) to maintain the state of the game and to (ii) determine if the game has been solved.
 */

-(void) setSolutionArray: (NSMutableArray *)solution;

-(BOOL) gameSolved;

-(void) maintainState: (NSMutableArray *)state;

-(NSMutableArray *) moveRight;
-(NSMutableArray *) moveLeft;
-(NSMutableArray *) moveDown;
-(NSMutableArray *) moveUp;
@end
