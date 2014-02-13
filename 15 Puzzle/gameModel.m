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
        
        //self.win = self.gameSolved;
    }
    self.firstRun++;
}






-(NSMutableArray *) moveRight
{
    NSLog(@"Move Right");
    UIButton *blankButton = [self.solvedState objectAtIndex:15];
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == blankButton && i % 4 != 0) {
            
            UIButton *swap1 = [self.currentState objectAtIndex:i];
            UIButton *swap2 = [self.currentState objectAtIndex:i-1];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            [UIView animateWithDuration:.75 animations:^{
                [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                [[self.currentState objectAtIndex:i-1] setCenter:swapPoint1];
            }];
            
            [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i-1];
            break;
        }
    }
    return self.currentState;
}

-(NSMutableArray *) moveLeft
{
    NSLog(@"Move Left");
    UIButton *blankButton = [self.solvedState objectAtIndex:15];
    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == blankButton && i % 4 != 3) {
            
            UIButton *swap1 = [self.currentState objectAtIndex:i];
            UIButton *swap2 = [self.currentState objectAtIndex:i+1];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            [UIView animateWithDuration:.75 animations:^{
                [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                [[self.currentState objectAtIndex:i+1] setCenter:swapPoint1];
            }];
            
            
            [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i+1];
            break;
        }
        
    }
    return self.currentState;
}

-(NSMutableArray *) moveDown
{
    NSLog(@"Move Down");
    
    UIButton *blankButton = [self.solvedState objectAtIndex:15];
    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == blankButton && i > 3) {
            
            UIButton *swap1 = [self.currentState objectAtIndex:i];
            UIButton *swap2 = [self.currentState objectAtIndex:i-4];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            [UIView animateWithDuration:.75 animations:^{
                [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                [[self.currentState objectAtIndex:i-4] setCenter:swapPoint1];
            }];
            
            [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i-4];
            break;
        }
    }
    return self.currentState;
}

-(NSMutableArray *) moveUp
{
    NSLog(@"Move Up");
    
    UIButton *blankButton = [self.solvedState objectAtIndex:15];
    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == blankButton && i < 12) {
            
            UIButton *swap1 = [self.currentState objectAtIndex:i];
            UIButton *swap2 = [self.currentState objectAtIndex:i+4];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            [UIView animateWithDuration:.75 animations:^{
                [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                [[self.currentState objectAtIndex:i+4] setCenter:swapPoint1];
            }];
            
            [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i+4];
            break;
        }
    }
    return self.currentState;
}







@end
