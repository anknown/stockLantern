//
//  StockMonitorItem.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/15.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "StockMonitorItem.h"

@implementation StockMonitorItem

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:STOCK_MON_ITEM_NAME_KEY];
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld", self.index] forKey:STOCK_MON_ITEM_IDX_KEY];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:STOCK_MON_ITEM_NAME_KEY];
        self.index = [[aDecoder decodeObjectForKey:STOCK_MON_ITEM_IDX_KEY] integerValue];
    }
    
    return self;
}

@end
