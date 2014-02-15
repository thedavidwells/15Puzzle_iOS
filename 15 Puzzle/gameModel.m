//  15 PUZZLE
//  PROJECT 2
//  CS470 - Spring 2014
//
//  CREATED BY DAVID WELLS
//  Copyright (c) 2014 David Wells. All rights reserved.
//  All code not provided by Professor Kooshesh is the sole work of David Wells for CS470 at Sonoma State University.

#import "gameModel.h"

@interface gameModel()



@property(nonatomic) int firstRun;
@property(nonatomic) bool win;
@end



@implementation gameModel

/*
CGPoint button1Point;
CGPoint button2Point;
CGPoint button3Point;
CGPoint button4Point;
CGPoint button5Point;
CGPoint button6Point;
CGPoint button7Point;
CGPoint button8Point;
CGPoint button9Point;
CGPoint button10Point;
CGPoint button11Point;
CGPoint button12Point;
CGPoint button13Point;
CGPoint button14Point;
CGPoint button15Point;
CGPoint blankButtonPoint;
*/

//UIButton *blankButton = [self.solvedState objectAtIndex:15];

-(void) setSolutionArray: (NSMutableArray *)solution
{
    if (! _solvedState ) {
        _solvedState = [[NSMutableArray alloc] init];
    }
    
    NSLog(@"Solved state in the model has: %lu items", (unsigned long)self.solvedState.count);
    
    /*
    button1Point = CGPointMake(self.button1.frame.origin.x, self.button1.frame.origin.y);
    button2Point = CGPointMake(self.button2.frame.origin.x, self.button2.frame.origin.y);
    button3Point = CGPointMake(self.button3.frame.origin.x, self.button3.frame.origin.y);
    button4Point = CGPointMake(self.button4.frame.origin.x, self.button4.frame.origin.y);
    button5Point = CGPointMake(self.button5.frame.origin.x, self.button5.frame.origin.y);
    button6Point = CGPointMake(self.button6.frame.origin.x, self.button6.frame.origin.y);
    button7Point = CGPointMake(self.button7.frame.origin.x, self.button7.frame.origin.y);
    button8Point = CGPointMake(self.button8.frame.origin.x, self.button8.frame.origin.y);
    button9Point = CGPointMake(self.button9.frame.origin.x, self.button9.frame.origin.y);
    button10Point = CGPointMake(self.button10.frame.origin.x, self.button10.frame.origin.y);
    button11Point = CGPointMake(self.button11.frame.origin.x, self.button11.frame.origin.y);
    button12Point = CGPointMake(self.button12.frame.origin.x, self.button12.frame.origin.y);
    button13Point = CGPointMake(self.button13.frame.origin.x, self.button13.frame.origin.y);
    button14Point = CGPointMake(self.button14.frame.origin.x, self.button14.frame.origin.y);
    button15Point = CGPointMake(self.button15.frame.origin.x, self.button15.frame.origin.y);
    blankButtonPoint = CGPointMake(self.blankButton.frame.origin.x, self.blankButton.frame.origin.y);
     */
}

-(void) getButtons: (UIButton*)aParticularButton
{
    if (! _solvedState ) {
        _solvedState = [[NSMutableArray alloc] init];
    }
    [self.solvedState addObject:aParticularButton];
    NSLog(@"Number of items in solution array: %lu", (unsigned long)[self.solvedState count]);
    

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


-(void) maintainState
{
    if (!_currentState) {
        self.currentState = [[NSMutableArray alloc] init];
        [self.currentState setArray:self.solvedState];
    }
    

    
    if (self.firstRun > 0) {
        
        //self.win = self.gameSolved;
    }
    self.firstRun++;
    
    NSLog(@"Current state in the model has: %lu items", (unsigned long)self.currentState.count);
}






-(void) moveRight
{
    NSLog(@"Move Right");
    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i % 4 != 0) {
            
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

}

-(void) moveLeft
{
    NSLog(@"Move Left");

    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i % 4 != 3) {
            
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

}

-(void) moveDown
{
    NSLog(@"Move Down");
    
   
    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i > 3) {
            
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

}

-(void) moveUp
{
    NSLog(@"Move Up");
    

    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i < 12) {
            
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

}


-(void) performResetLogic
{
    NSLog(@"In reset function - MODEL");
    for (int i = 0; i < [self.currentState count]; i++) {
        UIButton *currentButton = [self.currentState objectAtIndex:i];
        UIButton *solutionButton = [self.solvedState objectAtIndex:i];
        
        NSLog(@"CurrentState[%i]: %ld", i, (long)currentButton.tag);
        NSLog(@"SolutionState[%i]: %ld", i, (long)solutionButton.tag);
        
        CGPoint currentPoint = currentButton.center;
        CGPoint solutionPoint = solutionButton.center;
        
        [UIView animateWithDuration:1 animations:^{
            NSLog(@"Moving from %ld to %ld", (long)currentButton.tag, (long)solutionButton.tag);
            [currentButton setCenter:solutionPoint];
            
            NSLog(@"Moving from %ld to %ld", (long)solutionButton.tag, (long)currentButton.tag);
            [solutionButton setCenter:currentPoint];
            
            }];

        for (int k = 0; k < [self.currentState count]; k++) {
            if ([self.currentState objectAtIndex:k] == solutionButton  ) {
                
                NSLog(@"Replacing object at index %d with %ld", k, (long)currentButton.tag);
                [self.currentState replaceObjectAtIndex:k withObject:currentButton];
                
                break;
            }
        }

        [self.currentState replaceObjectAtIndex:i withObject:solutionButton];
    }
    
}



-(void)doTheShuffle: (int) steps
{
    if (steps == 0) {
        return;
    }
    [UIView animateWithDuration:.25
                     animations:^{
                         
                         
                         int temp = arc4random() % 4;
                         NSLog(@"Random #: %d", temp);
                         
                         if (temp == 0 ) {
                             
                             for (int i = 0; i < [self.currentState count]; i++) {
                                 
                                 if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i % 4 != 3) {
                                     
                                     UIButton *swap1 = [self.currentState objectAtIndex:i];
                                     UIButton *swap2 = [self.currentState objectAtIndex:i+1];
                                     
                                     CGPoint swapPoint1 = swap1.center;
                                     CGPoint swapPoint2 = swap2.center;
                                     
                                     
                                     [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentState objectAtIndex:i+1] setCenter:swapPoint1];
                                     [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                                     
                                     break;
                                 }
                                 
                             }
                         }
                         
                         
                         else if (temp == 1) {
                             
                             for (int i = 0; i < [self.currentState count]; i++) {
                                 
                                 if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i % 4 != 0) {
                                     
                                     UIButton *swap1 = [self.currentState objectAtIndex:i];
                                     UIButton *swap2 = [self.currentState objectAtIndex:i-1];
                                     
                                     CGPoint swapPoint1 = swap1.center;
                                     CGPoint swapPoint2 = swap2.center;
                                     
                                     
                                     [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentState objectAtIndex:i-1] setCenter:swapPoint1];
                                     [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i-1];
                                     
                                     break;
                                 }
                                 
                             }
                         }
                         
                         
                         else if (temp == 2) {
                             
                             for (int i = 0; i < [self.currentState count]; i++) {
                                 
                                 if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i < 12) {
                                     
                                     UIButton *swap1 = [self.currentState objectAtIndex:i];
                                     UIButton *swap2 = [self.currentState objectAtIndex:i+4];
                                     
                                     CGPoint swapPoint1 = swap1.center;
                                     CGPoint swapPoint2 = swap2.center;
                                     
                                     
                                     [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentState objectAtIndex:i+4] setCenter:swapPoint1];
                                     [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i+4];
                                     
                                     break;
                                 }
                                 
                             }
                         }
                         
                         
                         else if (temp == 3) {
                             
                             for (int i = 0; i < [self.currentState count]; i++) {
                                 
                                 if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i > 3) {
                                     
                                     UIButton *swap1 = [self.currentState objectAtIndex:i];
                                     UIButton *swap2 = [self.currentState objectAtIndex:i-4];
                                     
                                     CGPoint swapPoint1 = swap1.center;
                                     CGPoint swapPoint2 = swap2.center;
                                     
                                     [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentState objectAtIndex:i-4] setCenter:swapPoint1];
                                     [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i-4];
                                     
                                     break;
                                 }
                                 
                             }
                             
                         }
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self doTheShuffle:steps-1];
                         
                     }];
    
    
}




@end
