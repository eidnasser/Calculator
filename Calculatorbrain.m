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
-(double) popOperand
{
    NSNumber *operandObject=[self.operandStack lastObject];
    if (operandObject)
    {
        [self.operandStack removeLastObject];
    }
  

    return [operandObject doubleValue];
        
}
-(void)clearOperand
{
    [self.programStack removeAllObjects];
    //return;
}
//-(void) setOperandstack:(NSMutableArray *)anarray
//{
  //  operandstack = anarray;
    
//}
-(void)pushOperant:(double)operand
{
   // NSLog(@"%d:%g",[self.operandStack count],operand);
   NSNumber *operandObject=[NSNumber numberWithDouble:operand];
   //NSLog(@"contents %@",self.operandStack);
    [self.programStack addObject:operandObject];
    
}   
 
-(double)performOperation:(NSString *)opration
{
    [self.programStack addObject:opration];
   return  [Calculatorbrain runProgram:self.program];
}

-(id)program
 {
     return [self.programStack copy];
     
}

+(NSString *)descriptionOfProgram:(id)program
{
  return @"implement in assignment 2";
}

+(double) popOperandOfStack:(NSMutableArray *) stack
{
    double result=0;
    
    id topOfStack=[stack lastObject];
    if (topOfStack) [stack removeLastObject];
    if ([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]){
    
        NSString *opration=topOfStack;
        if([opration isEqualToString:@"+"])
        {
            double sumtemp=[self popOperandOfStack:stack];
            // NSLog(@"number=%g",sumtemp);
            
            result=sumtemp+[self popOperandOfStack:stack];
        } else if ([@"*" isEqualToString:opration])
        {
            result=[self popOperandOfStack:stack]*[self popOperandOfStack:stack];
            
        }else if ([@"-" isEqualToString:opration])
        {
            double subtrahand =[self popOperandOfStack:stack];
            result=[self popOperandOfStack:stack]-subtrahand;
            
        }else if([@"/" isEqualToString:opration])
        {
            double divisor= [self popOperandOfStack:stack];
            if(divisor) result=[self popOperandOfStack:stack]/divisor;
        }else if ([@"Sqrt" isEqualToString:opration])
        {
            result = sqrt([self popOperandOfStack:stack]);
            
        }else if([@"Sin" isEqualToString:opration])
        {
            result=sin([self popOperandOfStack:stack]);
            
        }else if([@"Cos" isEqualToString:opration])
        {
            result=cos([self popOperandOfStack:stack]);
        }else if([@"Log" isEqualToString:opration])
        {
            result=log([self popOperandOfStack:stack]);
        }else if([@"π" isEqualToString:opration])
        {
            result = (3.14)*([self popOperandOfStack:stack]);
        }else if([@"C" isEqualToString:opration])
        {
            [stack removeAllObjects];
            
            result= 0;
            
        }

    
    
    }
    
    return result;
    NSLog(@"result=%g",result);
    

}

+(double) runProgram:(id)program

{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]){
        stack=[program mutableCopy];
    
    }
    return [self popOperandOfStack:stack];
    }
    


   // double result=0;
     
    
    
    
    
//else if([@"- / +" isEqualToString:opration])
  //  {
    //    NSLog(@"number4444=%g",self.popOperand);
      //  result = (-1) *(self.popOperand) ;
   // }
    
    

@end
