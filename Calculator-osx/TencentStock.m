//
//  TencentStock.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/3.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "TencentStock.h"

enum tokenIdx {
    NAME = 1,
    CODE = 2,
    PRICE = 3,
    TIME = 30,
    PERCENT = 32,
    VOL = 36,
    AMOUNT = 37
};

@interface TencentStock ()

- (NSString *) formatTime: (NSString *)time;

@end

@implementation TencentStock

- (NSString *) formatTime: (NSString *)time{
    NSString *y = [time substringWithRange:NSRangeFromString(@"{0, 4}")];
    NSString *m = [time substringWithRange:NSRangeFromString(@"{4, 2}")];
    NSString *d = [time substringWithRange:NSRangeFromString(@"{6, 2}")];
    NSString *h = [time substringWithRange:NSRangeFromString(@"{8, 2}")];
    NSString *i = [time substringWithRange:NSRangeFromString(@"{10, 2}")];
    NSString *s = [time substringWithRange:NSRangeFromString(@"{12, 2}")];
    
    NSString *formatedTime = [[NSString alloc] init];
    formatedTime = [formatedTime stringByAppendingString:y];
    formatedTime = [formatedTime stringByAppendingString:@"-"];
    formatedTime = [formatedTime stringByAppendingString:m];
    formatedTime = [formatedTime stringByAppendingString:@"-"];
    formatedTime = [formatedTime stringByAppendingString:d];
    formatedTime = [formatedTime stringByAppendingString:@" "];
    formatedTime = [formatedTime stringByAppendingString:h];
    formatedTime = [formatedTime stringByAppendingString:@":"];
    formatedTime = [formatedTime stringByAppendingString:i];
    formatedTime = [formatedTime stringByAppendingString:@":"];
    formatedTime = [formatedTime stringByAppendingString:s];
    
    return formatedTime;
}

- (instancetype) initWithString:(NSString *)string{
    if (string == nil || [string isEqualToString:@""]) {
        return nil;
    }
    
    NSArray *tokens = [string componentsSeparatedByString:@"~"];
    
    if (tokens != nil) {
        NSRange range;
        range.length = 8;
        range.location = 2;
        self.codeEx = [tokens[0] substringWithRange:range];        
        self.name = [tokens[NAME] stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.code = tokens[CODE];
        self.price = tokens[PRICE];
        self.time = [self formatTime:tokens[TIME]];

        self.percent = [tokens[PERCENT] stringByAppendingString:@"%"];
        float vol = [tokens[VOL] floatValue];
        if (vol > 9999) {
            self.vol = [NSString stringWithFormat:@"%.2f万股", vol/10000];
        }
        else{
            self.vol = [NSString stringWithFormat:@"%d股", (int)vol];
        }
        float amount = [tokens[AMOUNT] floatValue];
        if (amount > 9999.999) {
            self.amount = [NSString stringWithFormat:@"%.2f亿", amount/10000];
        }
        else {
            self.amount = [NSString stringWithFormat:@"%d万", (int)amount];
        }
    } else {
        return nil;
    }
    
    return self;
}

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

@end
