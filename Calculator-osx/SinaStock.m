//
//  SinaStock.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/14.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "SinaStock.h"

@implementation SinaStock

- (NSMutableArray *) stockListWithString: (NSString *)string{
    if (string == nil || [string isEqualToString:@""]) {
        return nil;
    }
    
    NSString *subString = [[[string substringFromIndex:[string rangeOfString:@"="].location + 1] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSArray *tokens = [subString componentsSeparatedByString:@";"];
    
    NSMutableArray *stockList = [[NSMutableArray alloc]init];
    
    if (tokens != nil) {
        for (NSString *token in tokens) {
            if([token isEqualToString:@""]){
                continue;
            }
            
            NSArray *subTokens = [token componentsSeparatedByString:@","];
            if (subTokens == nil || subTokens.count < 6) {
                continue;
            }
            
            NSString *abbreviate = subTokens[0];
            NSString *code = subTokens[2];
            NSString *name = subTokens[4];
            NSString *codeEx = subTokens[3];
            if (![subTokens[1] isEqualToString:@"11"]) {
                continue;
            }
            
            SinaStock *stock = [[SinaStock alloc]init];
            stock.code = code;
            stock.name = name;
            stock.codeEx = codeEx;
            stock.abbreviate = abbreviate;
            
            [stockList addObject:stock];
        }
    }
    
    return stockList;
}

@end
