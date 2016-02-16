//
//  MyStock.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/3.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "MyStock.h"

@implementation MyStock

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.code forKey:STOCK_CODE_NAME];
    [aCoder encodeObject:self.name forKey:STOCK_NAME_NAME];
    [aCoder encodeObject:self.time forKey:STOCK_TIME_NAME];
    [aCoder encodeObject:self.price forKey:STOCK_PRICE_NAME];
    [aCoder encodeObject:self.percent forKey:STOCK_PERCENT_NAME];
    [aCoder encodeObject:self.vol forKey:STOCK_VOL_NAME];
    [aCoder encodeObject:self.amount forKey:STOCK_AMOUNT_NAME];
    [aCoder encodeObject:self.codeEx forKey:STOCK_CODE_EX_NAME];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.code = [aDecoder decodeObjectForKey:STOCK_CODE_NAME];
        self.name = [aDecoder decodeObjectForKey:STOCK_NAME_NAME];
        self.time = [aDecoder decodeObjectForKey:STOCK_TIME_NAME];
        self.time = [aDecoder decodeObjectForKey:STOCK_PRICE_NAME];
        self.percent = [aDecoder decodeObjectForKey:STOCK_PERCENT_NAME];
        self.vol = [aDecoder decodeObjectForKey:STOCK_VOL_NAME];
        self.amount = [aDecoder decodeObjectForKey:STOCK_AMOUNT_NAME];
        self.codeEx = [aDecoder decodeObjectForKey:STOCK_CODE_EX_NAME];
    }
    
    return self;
}

- (void) print{
    NSLog(@"%@ %@ %@ %@ %@ %@ %@", self.code, self.name, self.price, self.percent, self.vol, self.amount, self.codeEx);
}

@end
