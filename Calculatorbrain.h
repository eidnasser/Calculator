//
//  Calculatorbrain.h
//  Calculator
//
//  Created by EHK on 3/7/13.
//  Copyright (c) 2013 EHK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculatorbrain : NSObject
-(void)pushOperant:(double)operand;
-(double)performOperation:(NSString *)opration;
-(double)popOperand;
@property (readonly )id program;
+ (double)runProgram:(id)program;
+ (NSString *) descriptionOfProgram:(id)program;





@end
