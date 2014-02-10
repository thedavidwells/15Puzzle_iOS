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

@property(nonatomic) NSMutableDictionary *pointDict;

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
    
    [self createSolvedState];
    //NSLog(@"Solved state in the view has: %d items", self.solvedState.count);
    
    [self initializeSwipeGestureRecognizers];
    [self getTileLocation];
    
    // NSLog(@"Current game state array size: %d", [self.currentGameState count]);
    // NSLog(@"Location: %@", NSStringFromCGPoint(button1Point));
    
    [self.gameLogic setSolutionArray:self.solvedState];
    [self.gameLogic maintainState:self.currentGameState];
    
    
    
    
}


-(void) leftSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped left!");
    [self getTileLocation];
    [self swapLeft];
    
    [self.gameLogic maintainState:self.currentGameState];
}

-(void) rightSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped right!");
    [self getTileLocation];
    [self swapRight];
    
    [self.gameLogic maintainState:self.currentGameState];
}

-(void) upSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped up!");
    [self getTileLocation];
    [self swapUp];
    NSLog(@"Current game state array size: %d", [self.currentGameState count]);
    
    [self.gameLogic maintainState:self.currentGameState];
}

-(void) downSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped down!");
    [self getTileLocation];
    [self swapDown];
    
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
    
    if (!_pointDict) {
        self.pointDict = [[NSMutableDictionary alloc] init];
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

    
    
    [self.pointDict setValue:NSStringFromCGPoint(button1Point) forKey:self.button1.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button2Point) forKey:self.button2.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button3Point) forKey:self.button3.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button4Point) forKey:self.button4.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button5Point) forKey:self.button5.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button6Point) forKey:self.button6.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button7Point) forKey:self.button7.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button8Point) forKey:self.button8.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button9Point) forKey:self.button9.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button10Point) forKey:self.button10.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button11Point) forKey:self.button11.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button12Point) forKey:self.button12.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button13Point) forKey:self.button13.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button14Point) forKey:self.button14.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(button15Point) forKey:self.button14.currentTitle];
    [self.pointDict setValue:NSStringFromCGPoint(blankButtonPoint) forKey:self.blankButton.currentTitle];
    
        /*
    for (NSString *key in [self.pointDict allKeys]) {
        NSLog(@"Button %@ - %@", key, [self.pointDict objectForKey:key]);
    }
         */
    
    
    if (!_currentGameState) {
        self.currentGameState = [[NSMutableArray alloc] init];
        [self.currentGameState setArray:self.solvedState];
    }
    
}

- (IBAction)shuffleTiles:(UIButton *)sender
{
    
    self.shuffleSteps = (int)(self.difficultySlider.value * 50.0);
    NSLog(@"Shuffle value: %d", self.shuffleSteps);
    
    
    NSLog(@"Number of items in array: %d", [self.currentGameState count]);
    for (int i = 0; i < self.shuffleSteps; i++) {
        
        int temp = arc4random() % 4;
        
        if (temp == 1) {
            [self swapLeft];
        }
        
        if (temp == 2) {
            [self swapRight];
        }
        
        if (temp == 3) {
            [self swapUp];
        }
        
        if (temp == 4) {
            [self swapDown];
        }
        
    }
    
    
}



- (IBAction)resetGame:(UIButton *)sender {
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        
        UIButton *currentButton = [self.currentGameState objectAtIndex:i];
        UIButton *originalButton = [self.solvedState objectAtIndex:i];
        CGPoint originalPoint = originalButton.center;
        
        int index = currentButton.tag;
        NSLog(@"Tag: %d", index);
        
        [UIView animateWithDuration:1.5 animations:^{
            [currentButton setCenter:originalPoint];
            
        }];
        

        NSLog(@"current button: %@", currentButton.titleLabel);
        
        
    }
    [self getTileLocation];
    [self.currentGameState setArray:self.solvedState];

}


-(void) swapLeft
{
    NSLog(@"Swap Left");
    
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        // NSLog(@"COUNT: %D", i);
        // NSLog(@"i mod 4 = %D", i%4);
        if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i % 4 != 0) {
            
            // NSLog(@"In LEFT loop!");
            
            UIButton *swap1 = [self.currentGameState objectAtIndex:i];
            UIButton *swap2 = [self.currentGameState objectAtIndex:i-1];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            
            [UIView animateWithDuration:1 animations:^{
            
                [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                
            }];
            
            [UIView animateWithDuration:1 animations:^{
                
                [[self.currentGameState objectAtIndex:i-1] setCenter:swapPoint1];
                
            }];
            
            [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i-1];
            // NSLog(@"Current i value after swap: %d", i-1);
            break;
        }
        
    }
    
    
}

-(void) swapRight
{
    NSLog(@"Swap Right");
    
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        
        if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i % 4 != 3) {
            
            // NSLog(@"In RIGHT loop!");
            
            UIButton *swap1 = [self.currentGameState objectAtIndex:i];
            UIButton *swap2 = [self.currentGameState objectAtIndex:i+1];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            
            [UIView animateWithDuration:1 animations:^{
                
                [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                
            }];
            
            [UIView animateWithDuration:1 animations:^{
                
                [[self.currentGameState objectAtIndex:i+1] setCenter:swapPoint1];
                
            }];
            
            [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i+1];
            // NSLog(@"Current i value after swap: %d", i+4);
            break;
        }
        
    }

    
    
}
-(void) swapUp
{
    NSLog(@"Swap Up");
    
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        
        if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i > 3) {
            
            // NSLog(@"In UP loop!");
            // NSLog(@"Current i value: %d", i);
            
            UIButton *swap1 = [self.currentGameState objectAtIndex:i];
            UIButton *swap2 = [self.currentGameState objectAtIndex:i-4];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            
            [UIView animateWithDuration:1 animations:^{
                
                [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                
            }];
            
            [UIView animateWithDuration:1 animations:^{
                
                [[self.currentGameState objectAtIndex:i-4] setCenter:swapPoint1];
                
            }];
            
            [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i-4];
            // NSLog(@"Current i value after swap: %d", i-4);
            break;
        }
        
    }
}

-(void) swapDown
{
    NSLog(@"Swap Down");
    
    
    for (int i = 0; i < [self.currentGameState count]; i++) {
        
        if ( [self.currentGameState objectAtIndex:i] == self.blankButton && i < 12) {
            
            // NSLog(@"In DOWN loop!");
            // NSLog(@"Current i value: %d", i);
            
            UIButton *swap1 = [self.currentGameState objectAtIndex:i];
            UIButton *swap2 = [self.currentGameState objectAtIndex:i+4];
            
            CGPoint swapPoint1 = swap1.center;
            CGPoint swapPoint2 = swap2.center;
            
            
            [UIView animateWithDuration:1 animations:^{
                
                [[self.currentGameState objectAtIndex:i] setCenter:swapPoint2];
                // NSLog(@"Current i value: %d", i);
                
            }];
            
            [UIView animateWithDuration:1 animations:^{
                
                [[self.currentGameState objectAtIndex:i+4] setCenter:swapPoint1];
                // NSLog(@"Current i+4 value: %d", i+4);
                
            }];
            
            [self.currentGameState exchangeObjectAtIndex:i withObjectAtIndex:i+4];
            // NSLog(@"Current i value after swap: %d", i+4);
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
