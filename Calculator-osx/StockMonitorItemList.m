//
//  StockMonitorItemList.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/15.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "StockMonitorItemList.h"

@interface StockMonitorItemList()

@end

@implementation StockMonitorItemList

- (instancetype) initWithContentsOfFile: (NSString *)path {
    NSMutableArray *monitorItemArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:path]];

    if (monitorItemArray == nil || monitorItemArray.count < 1) {
        StockMonitorItem *itemCode = [[StockMonitorItem alloc]init];
        itemCode.name = STOCK_CODE_NAME;
        itemCode.index = STOCK_CODE_IDX;
        
        StockMonitorItem *itemName = [[StockMonitorItem alloc]init];
        itemName.name = STOCK_NAME_NAME;
        itemName.index = STOCK_NAME_IDX;
        
        StockMonitorItem *itemPrice = [[StockMonitorItem alloc]init];
        itemPrice.name = STOCK_PRICE_NAME;
        itemPrice.index = STOCK_PRICE_IDX;
        
        StockMonitorItem *itemPercent = [[StockMonitorItem alloc]init];
        itemPercent.name = STOCK_PERCENT_NAME;
        itemPercent.index = STOCK_PERCENT_IDX;
        
        if (monitorItemArray == nil) {
            monitorItemArray = [[NSMutableArray alloc]init];
        }

        [monitorItemArray addObject:itemCode];
        [monitorItemArray addObject:itemName];
        [monitorItemArray addObject:itemPrice];
        [monitorItemArray addObject:itemPercent];
    }
    self.monitorItemArray = monitorItemArray;
        
    return self;
}

- (void) writeToFile: (NSString *) path {
    NSData *stockListData = [NSKeyedArchiver archivedDataWithRootObject:self.monitorItemArray];
    [stockListData writeToFile:path atomically:YES];
}

- (void) addStockMonitorItem: (StockMonitorItem *) monitorItem{
    [self.monitorItemArray addObject: monitorItem];
}

- (NSInteger) positionOfStockMonitorItemByIndex: (NSInteger) index{
    int idx = -1;
    
    StockMonitorItem *m = [[StockMonitorItem alloc]init];
    
    for (int i = 0; i < self.monitorItemArray.count; ++i) {
        m = self.monitorItemArray[i];
        
        if (m.index == index) {
            idx = i;
            break;
        }
    }
    
    
    if (idx < 0 && idx >= self.monitorItemArray.count) {
        idx = -1;
    }
    
    NSInteger pos = idx;
    
    return pos;
}

- (void) removeAllStockMonitorItem{
    [self.monitorItemArray removeAllObjects];
}

@end
