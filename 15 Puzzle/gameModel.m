//  15 PUZZLE
//  PROJECT 2
//  CS470 - Spring 2014
//
//  CREATED BY DAVID WELLS
//  Copyright (c) 2014 David Wells. All rights reserved.
//  All code not provided by Professor Kooshesh is the sole work of David Wells for CS470 at Sonoma State University.

#import "gameModel.h"

@interface gameModel()

@property (nonatomic) NSMutableArray *solvedState;
@property (nonatomic) NSMutableArray *currentState;

@property(nonatomic) int firstRun;
@property(nonatomic) bool win;
@end



@implementation gameModel


-(void) setSolutionArray: (NSMutableArray *)solution
{
    self.solvedState = solution;
    
    NSLog(@"Solved state in the model has: %d items", self.solvedState.count);
}


-(BOOL) gameSolved
{
    bool solved = false;
    
    
    if ([self.solvedState isEqualToArray:self.currentState]) {
        // NSLog(@"YOU WIN!");
        solved = true;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WINNER!"
                                                        message:@"You have won!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    else{
        solved = false;
    }
    
    return solved;
}

-(void) maintainState: (NSMutableArray *)state
{
    self.currentState = state;
    
    if (self.firstRun > 0) {
        
        self.win = self.gameSolved;
    }
    self.firstRun++;
}












@end
