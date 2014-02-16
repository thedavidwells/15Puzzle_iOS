//  15 PUZZLE
//  PROJECT 2
//  CS470 - Spring 2014
//
//  CREATED BY DAVID WELLS
//  Copyright (c) 2014 David Wells. All rights reserved.
//  All code not provided by Professor Kooshesh is the sole work of David Wells for CS470 at Sonoma State University.

#import <Foundation/Foundation.h>

@interface gameModel : NSObject


@property (nonatomic) NSMutableArray *solvedState;
@property (nonatomic) NSMutableArray *currentState;

-(void) setSolutionArray: (NSMutableArray *)solution;
-(BOOL) gameSolved;
-(void) setCurrentState;
-(void) moveRight;
-(void) moveLeft;
-(void) moveDown;
-(void) moveUp;
-(void) doTheShuffle: (int) steps;
-(void) performResetLogic;
-(void) getButtons: (UIButton*)aParticularButton;

@end
