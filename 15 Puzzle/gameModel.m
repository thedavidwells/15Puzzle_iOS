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


//
//  SET SOLUTION ARRAY
//  If the solution array doesn't exist, this function initializes it.
//
-(void) setSolutionArray: (NSMutableArray *)solution
{
    if (! _solvedState ) {
        _solvedState = [[NSMutableArray alloc] init];
    }
}


//
//  GET BUTTONS
//  This function is called from the view controller and basically loads all
//  of the buttons into the solution state array in order.
//  Also will initialize the solvedState array if it doesn't exist.
//

-(void) getButtons: (UIButton*)aParticularButton
{
    if (! _solvedState ) {
        _solvedState = [[NSMutableArray alloc] init];
    }
    [self.solvedState addObject:aParticularButton];
}


//
//  GAME SOLVED
//  Checks to see if the current state is equal to the solved state,
//  which will indicate a winning/ solved state.
//  Once a player has solved the puzzle, an alert is displayed to let
//  the player know they are victorious.
//
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

//
//  MAINTAIN STATE
//  A simple funciton to set up the currentState array if it hasn't already been set up
//  and to call the game solved method, which tests if the game has been solved.
//
-(void) setCurrentState
{
    if (!_currentState) {
        self.currentState = [[NSMutableArray alloc] init];
        [self.currentState setArray:self.solvedState];
    }
    
    if (self.firstRun > 0) {
        self.win = self.gameSolved;
    }
    self.firstRun++;
}





//
//  MOVE FUNCTIONS
//  One of these four functions will be called when a swipe gesture is recognized.
//  Since the buttons are stored in an array and the game is a 4x4 box essentially,
//  I used mod-4 in order to be able to test the edge cases.
//  Also, in the solved state array, the object at index 15 is the blank button that
//  is being used for reference.
//
//  For all of the buttons I'm iterating through the current state array, testing to
//  see if the move is possible, and then I swap the buttons using the center points
//  as reference.  I use a temporary UIButton and CGPoint for both the current state
//  at index i, and the solution state at index i.
//
//  NOTE:  THE BLANK BUTTON IS BEING USED FOR REFERENCE IN ALL OF THE CASES
//
//  Pre-Condition:  The current state array needs to be initialized (not nil)
//  Post-Condition: If the move is legal, the button will be moved to a new position
//                  on screen and in the current start array.
//


//
//  MOVE RIGHT
//  In the case of a right move, mod-4 can't be 0 because that would mean
//  that the blank button is in the left-most column, and thus a right move
//  is not possible.  (There's nothing to the left of the blank tile)
//
-(void) moveRight
{
    NSLog(@"Move Right");
    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i % 4 != 0) {
            
            UIButton *swap1 = [self.currentState objectAtIndex:i];
            CGPoint swapPoint1 = swap1.center;
            
            UIButton *swap2 = [self.currentState objectAtIndex:i-1];
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

//
//  MOVE LEFT
//  In the case of a left move, mod-4 can't be 3 because that would mean
//  that the blank button is in the right-most column, and thus a left move
//  is not possible.  (Nothing to the right of the blank tile)
//
-(void) moveLeft
{
    NSLog(@"Move Left");

    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i % 4 != 3) {
            
            UIButton *swap1 = [self.currentState objectAtIndex:i];
            CGPoint swapPoint1 = swap1.center;
            
            UIButton *swap2 = [self.currentState objectAtIndex:i+1];
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

//
//  MOVE DOWN
//  In the case of a down move, i must be greater than 3 because anything less would
//  mean that the blank button is in the top row (of the box if you're thinking of it visually)
//  and thus there is nothing above it to move down. If you think of it in terms of the array, I'm
//  going to be swapping the blank tile with a tile above it, which is point i-4, so if
//  you have an i value less than 3 you will be out of bounds of the array.
//
-(void) moveDown
{
    NSLog(@"Move Down");
    
   
    
    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i > 3) {
            
            UIButton *swap1 = [self.currentState objectAtIndex:i];
            CGPoint swapPoint1 = swap1.center;
            
            UIButton *swap2 = [self.currentState objectAtIndex:i-4];
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


//
//  MOVE UP
//  In the case of an up move, i must be less than 12 because anything less would
//  mean that the blank button is in the bottom row (of the box if you're thinking of it visually)
//  and thus there is nothing below it to move up. If you think of it in terms of the array, I'm
//  going to be swapping the blank tile with a tile below it, which is point i+4, so if
//  you have an i value greater than 12 you will be out of bounds of the array.
//
-(void) moveUp
{
    NSLog(@"Move Up");
    

    for (int i = 0; i < [self.currentState count]; i++) {
        
        if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i < 12) {
            
            UIButton *swap1 = [self.currentState objectAtIndex:i];
            CGPoint swapPoint1 = swap1.center;
            
            UIButton *swap2 = [self.currentState objectAtIndex:i+4];
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



//
//  RESET FUNCTION
//  This function will be called when the RESET button is pressed.
//  It compares each button in the current state array with each
//  button in the solved state array.
//  The current state button is moved to the location of the original button
//  and then updates the current array.
//
//  Pre-Condition:  Works with currentState array which is initialized to be
//                  identical to the solvedState array, and is updated every
//                  time move is made.
//  Post-Condition: currentState array has been returned to the solved state,
//                  and buttons are in original natural order from 1-15 with
//                  the blank tile (tag "16") placed last.
//
-(void) performResetLogic
{

    for (int i = 0; i < [self.currentState count]; i++) {
        
        UIButton *currentButton = [self.currentState objectAtIndex:i];
        CGPoint currentPoint = currentButton.center;
        UIButton *solutionButton = [self.solvedState objectAtIndex:i];
        CGPoint solutionPoint = solutionButton.center;
        
        if (currentButton != solutionButton) {
            
            [UIView animateWithDuration:.75 animations:^{
                
                [currentButton setCenter:solutionPoint];
                [solutionButton setCenter:currentPoint];
                }];
        }
        for (int k = 0; k < [self.currentState count]; k++) {
            if ([self.currentState objectAtIndex:k] == solutionButton  ) {

                [self.currentState replaceObjectAtIndex:k withObject:currentButton];
                break;
            }
        }
        [self.currentState replaceObjectAtIndex:i withObject:solutionButton];
    }
    
}


//
//  SHUFFLE FUNCTION
//  This function will be called when the SHUFFLE button is pressed.
//  Calling the moveLeft, moveRight, moveUp, and moveDown functions within the
//  "animateWithDuration" function did not allow each animation to finish completely, so
//  I simply use the exact code from the above move functions in each of the below cases.
//
//  So what I did was I used a random number generator (arc4random) to get
//  random values between 0 and 3 (by using mod4).
//  Then I used 4 if-statements to determine which move to perform.
//  This simplistic algorithm does not take into account previous moves, and thus
//  there can sometimes be slight back and forth movement based on the numbers
//  generated by arc4random.
//  True randomness in this puzzle seemed to be out of the scope of this
//  skill building project, though could be implemented if needed.
//
//  Pre-Condition:  Both currentState and solvedState arrays need to be non-nil.
//  Post-Condition: The currentState array will be shuffled "randomly", and the
//                  buttons will appear in a random order.
//                  The shuffle amount is based on the slider value from the user interface.
//
-(void)doTheShuffle: (int) steps
{
    if (steps == 0) {
        return;
    }
    [UIView animateWithDuration:.20
                     animations:^{
                         
                         
                         int temp = arc4random() % 4;
                         NSLog(@"Random #: %d", temp);
                         
                         if (temp == 0 ) {
                             
                             //  PERFORM A LEFT MOVE
                             for (int i = 0; i < [self.currentState count]; i++) {
                                 
                                 if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i % 4 != 3) {
                                     
                                     UIButton *swap1 = [self.currentState objectAtIndex:i];
                                     CGPoint swapPoint1 = swap1.center;
                                     UIButton *swap2 = [self.currentState objectAtIndex:i+1];
                                     CGPoint swapPoint2 = swap2.center;
                                     
                                     
                                     [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentState objectAtIndex:i+1] setCenter:swapPoint1];
                                     [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                                     
                                     break;
                                 }
                             }
                         }
                         
                         
                         else if (temp == 1) {
                             
                             //  PERFORM A RIGHT MOVE
                             for (int i = 0; i < [self.currentState count]; i++) {
                                 
                                 if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i % 4 != 0) {
                                     
                                     UIButton *swap1 = [self.currentState objectAtIndex:i];
                                     CGPoint swapPoint1 = swap1.center;
                                     UIButton *swap2 = [self.currentState objectAtIndex:i-1];
                                     CGPoint swapPoint2 = swap2.center;
                                     
                                     
                                     [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentState objectAtIndex:i-1] setCenter:swapPoint1];
                                     [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i-1];
                                     
                                     break;
                                 }
                                 
                             }
                         }
                         
                         
                         else if (temp == 2) {
                             
                             //  PERFORM AN UP MOVE
                             for (int i = 0; i < [self.currentState count]; i++) {
                                 
                                 if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i < 12) {
                                     
                                     UIButton *swap1 = [self.currentState objectAtIndex:i];
                                     CGPoint swapPoint1 = swap1.center;
                                     UIButton *swap2 = [self.currentState objectAtIndex:i+4];
                                     CGPoint swapPoint2 = swap2.center;
                                     
                                     
                                     [[self.currentState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentState objectAtIndex:i+4] setCenter:swapPoint1];
                                     [self.currentState exchangeObjectAtIndex:i withObjectAtIndex:i+4];
                                     
                                     break;
                                 }
                                 
                             }
                         }
                         
                         
                         else if (temp == 3) {
                             
                             //  PERFORM A DOWN MOVE
                             for (int i = 0; i < [self.currentState count]; i++) {
                                 
                                 if ( [self.currentState objectAtIndex:i] == [self.solvedState objectAtIndex:15] && i > 3) {
                                     
                                     UIButton *swap1 = [self.currentState objectAtIndex:i];
                                     CGPoint swapPoint1 = swap1.center;
                                     UIButton *swap2 = [self.currentState objectAtIndex:i-4];
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
