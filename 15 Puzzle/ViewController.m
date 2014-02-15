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





- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Begin 15-Puzzle Implementation by David Wells:
    
    self.gameLogic = [[gameModel alloc] init];
    [self createSolvedState];
    [self.gameLogic maintainState];
    
    [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"goldskull.png"] forState:UIControlStateNormal];
    self.shuffleSteps = (int)(self.difficultySlider.value * 50.0);
    [self.difficultyLabel setText:[NSString stringWithFormat:@"%d", self.shuffleSteps]];
    
    
    [self initializeSwipeGestureRecognizers];

  
}


- (IBAction)shuffleValueChanged:(UISlider *)sender {
    
    self.shuffleSteps = (int)(self.difficultySlider.value * 50.0);
    [self.difficultyLabel setText:[NSString stringWithFormat:@"%d", self.shuffleSteps]];
}


-(void) leftSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped left!");

    [self.gameLogic moveLeft];
    

}

-(void) rightSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped right!");

    [self.gameLogic moveRight];
    

}

-(void) upSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped up!");

    [self.gameLogic moveUp];
    

}

-(void) downSwipeAction: (UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swiped down!");

    [self.gameLogic moveDown];
    

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



- (IBAction)shuffleTiles:(UIButton *)sender
{
    self.shuffleSteps = (int)(self.difficultySlider.value * 50.0);
    NSLog(@"Shuffle value: %d", self.shuffleSteps);

    [self.gameLogic doTheShuffle:self.shuffleSteps];
    
}






- (IBAction)resetGame:(UIButton *)sender {


    [self.gameLogic performResetLogic];
    
}




- (IBAction)didPressButton:(UIButton*)sender
{
    NSLog(@"Button %@ pressed", [sender currentTitle] );
}



-(void)createSolvedState{
    [self.gameLogic getButtons:self.button1];
    [self.gameLogic getButtons:self.button2];
    [self.gameLogic getButtons:self.button3];
    [self.gameLogic getButtons:self.button4];
    [self.gameLogic getButtons:self.button5];
    [self.gameLogic getButtons:self.button6];
    [self.gameLogic getButtons:self.button7];
    [self.gameLogic getButtons:self.button8];
    [self.gameLogic getButtons:self.button9];
    [self.gameLogic getButtons:self.button10];
    [self.gameLogic getButtons:self.button11];
    [self.gameLogic getButtons:self.button12];
    [self.gameLogic getButtons:self.button13];
    [self.gameLogic getButtons:self.button14];
    [self.gameLogic getButtons:self.button15];
    [self.gameLogic getButtons:self.blankButton];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
