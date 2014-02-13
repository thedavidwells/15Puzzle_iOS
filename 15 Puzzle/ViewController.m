//  15 PUZZLE
//  PROJECT 2
//  CS470 - Spring 2014
//
//  CREATED BY DAVID WELLS
//  Copyright (c) 2014 David Wells. All rights reserved.
//  All code not provided by Professor Kooshesh is the sole work of David Wells for CS470 at Sonoma State University.

#import "ViewController.h"
#import "gameModel.h"

@interface ViewController ()

@property(nonatomic) UISwipeGestureRecognizer *leftSwipe;
@property(nonatomic) UISwipeGestureRecognizer *rightSwipe;
@property(nonatomic) UISwipeGestureRecognizer *upSwipe;
@property(nonatomic) UISwipeGestureRecognizer *downSwipe;


@property(nonatomic) NSMutableArray *shuffled;
@property(nonatomic) int shuffleSteps;

@property(nonatomic) gameModel *gameLogic;

@end

@implementation ViewController

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



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Begin 15-Puzzle Implementation by David Wells:
    
    self.gameLogic = [[gameModel alloc] init];
    
    [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"goldskull.png"] forState:UIControlStateNormal];
    self.shuffleSteps = (int)(self.difficultySlider.value * 50.0);
    
    [self createSolvedState];
    [self initializeSwipeGestureRecognizers];
    [self getTileLocation];
    
    [self.gameLogic setSolutionArray:self.solvedState];
    [self.gameLogic maintainState:self.currentGameState];
    
    [self.difficultyLabel setText:[NSString stringWithFormat:@"%d", self.shuffleSteps]];
    
}


- (IBAction)shuffleValueChanged:(UISlider *)sender {
    
    self.shuffleSteps = (int)(self.difficultySlider.value * 50.0);
    [self.difficultyLabel setText:[NSString stringWithFormat:@"%d", self.shuffleSteps]];
}


-(void) leftSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped left!");
    [self getTileLocation];
    [self moveLeft];
    
    [self.gameLogic maintainState:self.currentGameState];
}

-(void) rightSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped right!");
    [self getTileLocation];
    [self moveRight];
    
    [self.gameLogic maintainState:self.currentGameState];
}

-(void) upSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped up!");
    [self getTileLocation];
    [self moveUp];
    NSLog(@"Current game state array size: %d", [self.currentGameState count]);
    
    [self.gameLogic maintainState:self.currentGameState];
}

-(void) downSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped down!");
    [self getTileLocation];
    [self moveDown];
    
    [self.gameLogic maintainState:self.currentGameState];
}

-(void) initializeSwipeGestureRecognizers
{
    self.leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipeAction:)];
    [self.leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeAction:)];
    [self.rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:self.rightSwipe];
    
    self.upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipeAction:)];
    [self.upSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:self.upSwipe];
    
    self.downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downSwipeAction:)];
    [self.downSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:self.downSwipe];
    
    
    
}

-(void) getTileLocation
{
    if (!_currentGameState) {
        self.currentGameState = [[NSMutableArray alloc] init];
        [self.currentGameState setArray:self.solvedState];
    }

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

}

- (IBAction)shuffleTiles:(UIButton *)sender
{
    self.shuffleSteps = (int)(self.difficultySlider.value * 50.0);
    NSLog(@"Shuffle value: %d", self.shuffleSteps);
    
    [self doTheShuffle:self.shuffleSteps];
    
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
                             
                             for (int i = 0; i < [self.currentGameState count]; i++) {
                                 
                                 if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i % 4 != 3) {
                                     
                                     UIButton *swap1 = [self.currentGameState objectAtIndex:i];
                                     UIButton *swap2 = [self.currentGameState objectAtIndex:i+1];
                                     
                                     CGPoint swapPoint1 = swap1.center;
                                     CGPoint swapPoint2 = swap2.center;
                                     
                                     
                                     [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentGameState objectAtIndex:i+1] setCenter:swapPoint1];
                                     [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i+1];
      
                                     break;
                                    }

                                }
                            }
                         
                         
                         else if (temp == 1) {
                             
                             for (int i = 0; i < [self.currentGameState count]; i++) {

                                 if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i % 4 != 0) {
                                     
                                     UIButton *swap1 = [self.currentGameState objectAtIndex:i];
                                     UIButton *swap2 = [self.currentGameState objectAtIndex:i-1];
                                     
                                     CGPoint swapPoint1 = swap1.center;
                                     CGPoint swapPoint2 = swap2.center;


                                     [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentGameState objectAtIndex:i-1] setCenter:swapPoint1];
                                     [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i-1];

                                     break;
                                    }
                                 
                                }
                            }
                         
                         
                         else if (temp == 2) {
                             
                             for (int i = 0; i < [self.currentGameState count]; i++) {
                                 
                                 if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i < 12) {
                                     
                                     UIButton *swap1 = [self.currentGameState objectAtIndex:i];
                                     UIButton *swap2 = [self.currentGameState objectAtIndex:i+4];
                                     
                                     CGPoint swapPoint1 = swap1.center;
                                     CGPoint swapPoint2 = swap2.center;

                                         
                                     [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentGameState objectAtIndex:i+4] setCenter:swapPoint1];
                                     [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i+4];
                                     
                                     break;
                                    }
                                 
                                }
                            }
                    
                         
                         else if (temp == 3) {
                             
                             for (int i = 0; i < [self.currentGameState count]; i++) {
                                 
                                 if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i > 3) {
                                     
                                     UIButton *swap1 = [self.currentGameState objectAtIndex:i];
                                     UIButton *swap2 = [self.currentGameState objectAtIndex:i-4];
                                     
                                     CGPoint swapPoint1 = swap1.center;
                                     CGPoint swapPoint2 = swap2.center;

                                     [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                                     [[self.currentGameState objectAtIndex:i-4] setCenter:swapPoint1];
                                     [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i-4];
                                     
                                     break;
                                    }
                                 
                                }

                            }
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self doTheShuffle:steps-1];
                         
                     }];
        

}



- (IBAction)resetGame:(UIButton *)sender {
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        
        UIButton *currentButton = [self.currentGameState objectAtIndex:i];
        UIButton *originalButton = [self.solvedState objectAtIndex:i];
        CGPoint originalPoint = originalButton.center;
        
        [UIView animateWithDuration:1.5 animations:^{
            [currentButton setCenter:originalPoint];
            }];
    }
    
    [self getTileLocation];
    [self.currentGameState setArray:self.solvedState];

}


-(void) moveRight;
{
    NSLog(@"Move Right");
    
    for (int i = 0; i < [self.currentGameState count]; i++) {

        if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i % 4 != 0) {

            UIButton *swap1 = [self.currentGameState objectAtIndex:i];
            UIButton *swap2 = [self.currentGameState objectAtIndex:i-1];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            [UIView animateWithDuration:.75 animations:^{
                [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                [[self.currentGameState objectAtIndex:i-1] setCenter:swapPoint1];
                }];

            [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i-1];
            break;
            }
        }
    
}

-(void) moveLeft
{
    NSLog(@"Move Left");
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        
        if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i % 4 != 3) {
            
            UIButton *swap1 = [self.currentGameState objectAtIndex:i];
            UIButton *swap2 = [self.currentGameState objectAtIndex:i+1];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;

            [UIView animateWithDuration:.75 animations:^{
                [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                [[self.currentGameState objectAtIndex:i+1] setCenter:swapPoint1];
                }];

            
            [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i+1];
            break;
            }
        
        }

}

-(void) moveDown
{
    NSLog(@"Move Down");
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        
        if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i > 3) {
            
            UIButton *swap1 = [self.currentGameState objectAtIndex:i];
            UIButton *swap2 = [self.currentGameState objectAtIndex:i-4];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;

            [UIView animateWithDuration:.75 animations:^{
                [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                [[self.currentGameState objectAtIndex:i-4] setCenter:swapPoint1];
                }];
            
            [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i-4];
            break;
            }
        }
    
}

-(void) moveUp
{
    NSLog(@"Move Up");
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        
        if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i < 12) {
            
            UIButton *swap1 = [self.currentGameState objectAtIndex:i];
            UIButton *swap2 = [self.currentGameState objectAtIndex:i+4];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            [UIView animateWithDuration:.75 animations:^{
                [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                [[self.currentGameState objectAtIndex:i+4] setCenter:swapPoint1];
                }];

            [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i+4];
            break;
            }
        }
}




- (IBAction)didPressButton:(UIButton*)sender
{
    NSLog(@"Button %@ pressed", [sender currentTitle] );
}


-(void)createSolvedState{
    
    if (! _solvedState ) {
        _solvedState = [[NSMutableArray alloc] init];
    }
    
    [self.solvedState addObject:self.button1];
    [self.solvedState addObject:self.button2];
    [self.solvedState addObject:self.button3];
    [self.solvedState addObject:self.button4];
    [self.solvedState addObject:self.button5];
    [self.solvedState addObject:self.button6];
    [self.solvedState addObject:self.button7];
    [self.solvedState addObject:self.button8];
    [self.solvedState addObject:self.button9];
    [self.solvedState addObject:self.button10];
    [self.solvedState addObject:self.button11];
    [self.solvedState addObject:self.button12];
    [self.solvedState addObject:self.button13];
    [self.solvedState addObject:self.button14];
    [self.solvedState addObject:self.button15];
    [self.solvedState addObject:self.blankButton];
    
    NSLog(@"Number of items in array: %d", [self.solvedState count]);
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
