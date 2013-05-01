//
//  CalculatorViewController.m
//  Calculator
//
//  Created by EHK on 3/7/13.
//  Copyright (c) 2013 EHK. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Calculatorbrain.h"
#include <math.h>

@interface CalculatorViewController ()
@property (nonatomic) BOOL userinthemiddleofenteringnumber;
@property(nonatomic) BOOL floatPressedOrNo;

@property (nonatomic,strong) Calculatorbrain *brain;


@end

@implementation CalculatorViewController
@synthesize floatPressedOrNo;
@synthesize userinthemiddleofenteringnumber;
@synthesize brain=_brain;

-(Calculatorbrain *)brain
{
    if(!_brain) _brain=[[Calculatorbrain alloc] init];
    return  _brain;
}

- (IBAction)digitpressed:(UIButton *)sender
{
    NSString *digit=[sender currentTitle];
    
    if (self.userinthemiddleofenteringnumber ){
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else{
        self.display.text = digit;
        self.userinthemiddleofenteringnumber = YES;
    }
}

- (IBAction)floatPressed:(UIButton *)sender {
    NSString *floatPoint =[sender currentTitle];
    if (!self.floatPressedOrNo ){
        if(!self.userinthemiddleofenteringnumber){
            self.display.text = @"0" ;
            self.userinthemiddleofenteringnumber = YES;
        }
        self.display.text = [self.display.text stringByAppendingString:floatPoint];
        self.floatPressedOrNo=YES;
    }
}

- (IBAction)EnterPressed
{
    [self.brain pushOperant:[self.display.text doubleValue]];
    if(self.userinthemiddleofenteringnumber){
        self.DisplayAll.text = [self.DisplayAll.text stringByAppendingFormat:@"%g ",[self.display.text doubleValue]] ;
    }
    
    self.userinthemiddleofenteringnumber= NO;
    self.floatPressedOrNo=NO;
    
}


- (IBAction)operationpressed:(id)sender {
    if(self.userinthemiddleofenteringnumber)
    {
      [self EnterPressed];
    }
    
    NSString *opration =[sender currentTitle];
    if ([@"C" isEqualToString:opration])
    {
        self.DisplayAll.text =@"";
        double result=[self.brain performOperation:opration];
        self.display.text = [NSString stringWithFormat:@"%g",result];

    }
    else if([opration isEqualToString:@"π"]){
        [self.brain pushOperant:M_PI];
        //self.display.text = [self.display.text stringByAppendingFormat:@"%g",M_PI] ;
        self.DisplayAll.text = [self.DisplayAll.text stringByAppendingFormat:@"%@ ",opration];
    }
    else
    {
        self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:[sender currentTitle]] ;
        double result=[self.brain performOperation:opration];
        self.display.text = [NSString stringWithFormat:@"%g",result];
        self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:@" "];
    }
}

- (void)viewDidUnload {
    [self setDisplayAll:nil];
    [super viewDidUnload];
}
@end
