//  15 PUZZLE
//  PROJECT 2
//  CS470 - Spring 2014
//
//  CREATED BY DAVID WELLS
//  Copyright (c) 2014 David Wells. All rights reserved.
//  All code not provided by Professor Kooshesh is the sole work of David Wells for CS470 at Sonoma State University.

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic) UISwipeGestureRecognizer *leftSwipe;
@property(nonatomic) UISwipeGestureRecognizer *rightSwipe;
@property(nonatomic) UISwipeGestureRecognizer *upSwipe;
@property(nonatomic) UISwipeGestureRecognizer *downSwipe;

@end

@implementation ViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [self createSolvedState];
    
    
    
    
}


- (IBAction)shuffleTiles:(UIButton *)sender {
    
    
}

- (IBAction)didPressButton:(UIButton*)sender {
    
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
    
    NSLog(@"Number of items in array: %d", [self.solvedState count]);
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
