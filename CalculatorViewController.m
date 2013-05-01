//
//  CalculatorViewController.m
//  Calculator
//
//  Created by EHK on 3/7/13.
//  Copyright (c) 2013 EHK. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Calculatorbrain.h"

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
    
if (self.userinthemiddleofenteringnumber )
{
    self.display.text = [self.display.text stringByAppendingString:digit] ;
    self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:digit] ;
    self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:@" " ] ;

} else
{
    self.display.text=digit;
    self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:digit] ;
    self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:@" " ] ;
    self.userinthemiddleofenteringnumber = YES;
}
}
- (IBAction)floatPressed:(UIButton *)sender {
    NSString *flotPoint =[sender currentTitle];
    NSLog(@"flotpoint=%c",self.floatPressedOrNo);
        if (self.floatPressedOrNo )
        {
        self.display.text = [self.display.text stringByAppendingString:flotPoint] ;
            

        self.floatPressedOrNo=YES;
        
        
    }
}

- (IBAction)EnterPressed
{
    [self.brain pushOperant:[self.display.text doubleValue]];
    self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:@" " ] ;
   
     self.userinthemiddleofenteringnumber= NO;
    
}


- (IBAction)operationpressed:(id)sender {
    if(self.userinthemiddleofenteringnumber)
    {
      [self EnterPressed];
    }
    
    NSString *opration =[sender currentTitle];
    if ([@"C" isEqualToString:opration])
    {
        self.DisplayAll.text =@" ";
        double result=[self.brain performOperation:opration];
        self.display.text = [NSString stringWithFormat:@"%g",result];
        self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:@" " ] ;
        self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:[NSString stringWithFormat:@"%g",result]] ;

    }
    else
    {
    self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:[sender currentTitle]] ;
    double result=[self.brain performOperation:opration];
    self.display.text = [NSString stringWithFormat:@"%g",result];
        self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:@" " ] ;
        self.DisplayAll.text = [self.DisplayAll.text stringByAppendingString:[NSString stringWithFormat:@"%g",result]] ;

    }
}

- (void)viewDidUnload {
    [self setDisplayAll:nil];
    [super viewDidUnload];
}
@end
