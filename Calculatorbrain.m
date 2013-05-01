//
//  Calculatorbrain.m
//  Calculator
//
//  Created by EHK on 3/7/13.
//  Copyright (c) 2013 EHK. All rights reserved.
//

#import "Calculatorbrain.h"

@interface  Calculatorbrain()
@property (nonatomic,strong) NSMutableArray *operandStack;
@end

@implementation Calculatorbrain
@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack
{if (!_operandStack)
{
    _operandStack=[[NSMutableArray alloc] init];
    
}
    return _operandStack;
}

-(void) setOperandStack:(NSMutableArray *)anArray{
    _operandStack = anArray;
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
    [self.operandStack removeAllObjects];
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
    NSLog(@"contents %@",self.operandStack);
    [self.operandStack addObject:operandObject];
    
}

-(double)performOperation:(NSString *)opration
{
    double result=0;
    if([opration isEqualToString:@"+"]){
        result=[self popOperand]+[self popOperand];
    }
    else if ([@"*" isEqualToString:opration]){
        result=[self popOperand]*[self popOperand];
        
    }
    else if ([@"-" isEqualToString:opration]){
        double subtrahand =[self popOperand];
        result=[self popOperand]-subtrahand;
        
    }
    else if([@"/" isEqualToString:opration]){
        double divisor= [self popOperand];
        if(divisor) result=[self popOperand]/divisor;
    }
    else if ([@"Sqrt" isEqualToString:opration]){
        result = sqrt(self.popOperand);
        
    }
    else if([@"Sin" isEqualToString:opration]){
        result=sin(self.popOperand);
        
    }
    else if([@"Cos" isEqualToString:opration]){
        result=cos(self.popOperand);
    }
    else if([@"Log" isEqualToString:opration]){
        result=log(self.popOperand);
    }
    else if([@"π" isEqualToString:opration]){
        result = (3.14)*(self.popOperand);
    }
    else if([@"C" isEqualToString:opration])
    {
        [self clearOperand];
        return 0;
    }
    
    [self pushOperant:result];
    
    return result;
}
@end
