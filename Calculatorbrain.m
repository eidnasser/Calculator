//
//  Calculatorbrain.m
//  Calculator
//
//  Created by EHK on 3/7/13.
//  Copyright (c) 2013 EHK. All rights reserved.
//

#import "Calculatorbrain.h"

@interface  Calculatorbrain()
@property (nonatomic,strong) NSMutableArray *programStack;
@end

@implementation Calculatorbrain
@synthesize programStack = _programStack;

-(NSMutableArray *)operandStack
{if (!_programStack)
{
    _programStack=[[NSMutableArray alloc] init];
    
}
    return _programStack;
}

-(void) setOperandStack:(NSMutableArray *)anArray{
    _programStack = anArray;
}

 -(void)clearOperand
{
    [self.operandStack removeAllObjects];
    //return;
}

-(void)pushOperant:(double)operand
{
       NSNumber *operandObject=[NSNumber numberWithDouble:operand];
    NSLog(@"contents %@",self.operandStack);
    [self.programStack addObject:operandObject];
    
}

-(double)performOperation:(NSString *)opration
{
   
    [self.programStack addObject:opration];
    return [Calculatorbrain runProgram:self.program];
}
-(id)program
{
    return [self.programStack copy];
}
+(NSString *)descriptionOfProgram:(id)program
{
  // here we write the description of the program
}

+(double) popOperandOfStack:(NSMutableArray *)stack
{
    double result=0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack)[stack removeLastObject];
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        
        NSString *opration = topOfStack;
        if([opration isEqualToString:@"+"]){
            result=[self popOperandOfStack:stack]+[self popOperandOfStack:stack];
        }
        else if ([@"*" isEqualToString:opration]){
            result=[self popOperandOfStack:stack]*[self popOperandOfStack:stack];
            
        }
        else if ([@"-" isEqualToString:opration]){
            double subtrahand =[self popOperandOfStack:stack];
            result=[self popOperandOfStack:stack]-subtrahand;
            
        }
        else if([@"/" isEqualToString:opration]){
            double divisor= [self popOperandOfStack:stack];
            if(divisor) result=[self popOperandOfStack:stack]/divisor;
        }
        else if ([@"Sqrt" isEqualToString:opration]){
            result = sqrt([self popOperandOfStack:stack]);
            
        }
        else if([@"Sin" isEqualToString:opration]){
            result=sin([self popOperandOfStack:stack]);
            
        }
        else if([@"Cos" isEqualToString:opration]){
            result=cos([self popOperandOfStack:stack]);
        }
        else if([@"Log" isEqualToString:opration]){
            result=log([self popOperandOfStack:stack]);
        }
        else if([@"π" isEqualToString:opration]){
            result = (3.14)*([self popOperandOfStack:stack]);
        }
           }
    
    return result;
}

+(double) runProgram:(id)program
{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]])
    {
        stack=[program mutableCopy];
    }
    return [self popOperandOfStack:stack];
    
}

    @end
