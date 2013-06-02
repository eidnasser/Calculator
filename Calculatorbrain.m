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
@property(nonatomic,strong) NSMutableDictionary *varDictionary;

@end

@implementation Calculatorbrain
@synthesize varDictionary=_varDictionary;
@synthesize programStack = _programStack;

-(NSMutableArray *)operandStack
{if (!_programStack)
{
    _programStack=[[NSMutableArray alloc] init];
    
}
    return _programStack;
}



-(void) setDictionaryOfValues:(NSDictionary *) varDict
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"3",@"a",@"5",@"b",@"9",@"x", nil];
    
    _varDictionary=dict;
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
     //NSLog(@"contents %@",self.operandStack);
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


+(BOOL) isOperation:(id)operationName
{
    NSSet *operationSet =[NSSet setWithObjects:@"+",@"*",@"/",@"-",@"Sin",@"Cos",@"Sqrt",@"Log", nil ];
    if([operationSet containsObject:operationName])
    {
        return YES;
    }
    else
    {
        return NO ;
    }
}

+(NSNumber *) valueForVariable:(NSString *) nameOfVariable from:(NSDictionary *)variableValues
{
    
    id result=0;
    
    if([nameOfVariable isEqualToString:@"a"])
    {
        result=[variableValues valueForKey:@"a"];
        return result;
    }
    else if ([nameOfVariable isEqualToString:@"b"])
    {
        result=[variableValues valueForKey:@"b"];
        return result;
    }
    else if ([nameOfVariable isEqualToString:@"x"])
    {
        result=[variableValues valueForKey:@"x"];
        return result;
    }
    else
    {
        return 0;
    }
    
    
    
    
    //1-find the variable name in the dictionary
    //2- if the variable name is found return the nsnumber object
    //3-else return nsnumber with value zero
}

+(void) replaceProgram:(id) program variable:(NSString *) nameofVariable withValue:(NSNumber *) value
{
    NSMutableArray *stack1;
    if([program isKindOfClass:[NSArray class]])
    {
        stack1=[program mutableCopy];
    }
    
    
    for(NSObject *item in program)
    {
        if ([item isKindOfClass::[NSNumber Class]])
        {
            [stack1 addObject:item];
            
        }
        else
        {
            if([Calculatorbrain isOperation:item]){
                [stack1 addObject:item];
            }
            else
            {
                [stack1 addObject:[Calculatorbrain valueForVariable ]];
            
            }
        
        }
        
        
        
        // if (![Calculatorbrain isOperation:item]) {
         //   if (![item isKindOfClass:[NSNumber class]]) {
           //     [chkVar addObject:item];
            //}
        //}
    }
    
    
    //-go over the program and if the variable name is found replace it with value provided
}

-(void) pushVaiable:(NSString *) varaible
{
    [self.programStack addObject:varaible];
    
}

-(void) pushOperandToStack:(NSMutableArray *)stack
{

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
+(NSSet *)variableUsedInProgram:(id)program
{
    NSMutableSet *chkVar=[[NSMutableSet alloc]init];
    for(NSObject *item in program)
    {
        if (![Calculatorbrain isOperation:item]) {
            if (![item isKindOfClass:[NSNumber class]]) {
                [chkVar addObject:item];
            }
        }
    }
    
    if ([chkVar count]>0) {
        return [chkVar copy];
        
    }
    else {
        return nil;
    }
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