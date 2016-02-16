//
//  StockList.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/15.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "StockList.h"

@interface StockList()

@end

@implementation StockList

- (NSInteger) positionOfStockByCode: (NSString *) code {
    int idx = -1;
    
    MyStock *s = [[MyStock alloc]init];
    
    for (int i = 0; i < self.stockArray.count; ++i) {
        s = self.stockArray[i];
        
        if ([s.code isEqualToString: code]) {
            idx = i;
            break;
        }
    }
    
    
    if (idx < 0 && idx >= self.stockArray.count) {
        idx = -1;
    }
    
    NSInteger index = idx;
    
    return index;
}

- (StockList *) removeStockByCode: (NSString *) code {
    NSInteger idx = [self positionOfStockByCode: code];
    
    if (idx >= 0) {
        [self.stockArray removeObjectAtIndex:(NSUInteger)idx];
    }
    
    return self;
}

- (StockList *) removeStockByCode: (NSString *) code automatically: (BOOL) isAutomatic writeToFile: (NSString *) path {
    NSInteger idx = [self positionOfStockByCode: code];
    
    if (idx >= 0) {
        [self.stockArray removeObjectAtIndex:(NSUInteger)idx];
    }
    
    if (isAutomatic) {
        [self writeToFile:path];
    }
    
    return self;
}

- (instancetype) initWithContentsOfFile: (NSString *)path {
    NSMutableArray *stockArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:path]];
    
    NSLog(@"%@", stockArray);
    if (stockArray == nil) {
        MyStock *initStock = [[MyStock alloc]init];
        initStock.code = @"000001";
        initStock.name = @"上证指数";
        initStock.codeEx = @"sh000001";
        stockArray = [[NSMutableArray alloc]init];
        [stockArray addObject:initStock];
    }
    
    self.stockArray = stockArray;
    
    return self;
}

- (void) writeToFile: (NSString *) path {
    NSData *stockListData = [NSKeyedArchiver archivedDataWithRootObject:self.stockArray];
    [stockListData writeToFile:path atomically:YES];
}

- (MyStock *) stockAtIndex: (NSInteger) index {
    if (index < 0 && index >= self.stockArray.count) {
        return nil;
    }
    
    return self.stockArray[index];
}

- (void) addStock: (MyStock *)stock {
    if (stock != nil) {
        [self.stockArray addObject:stock];
    }
}

- (void) addStock: (MyStock *)stock automatically: (BOOL) isAutomatic writeToFile: (NSString *) path {
    [self.stockArray addObject:stock];
    if (isAutomatic) {
        [self writeToFile:path];
    }
}

- (NSInteger) countOfStockList {
    return self.stockArray.count;
}

- (instancetype) stockListByTencentString: (NSString *) string{
    if ([string isEqualToString:@""] || string == nil) {
        return nil;
    }
    
    NSArray *stockStringArray = [string componentsSeparatedByString:@";"];

    [self removeAllStock];
    
    for (NSString *stockString in stockStringArray) {
        TencentStock *stock = [[TencentStock alloc]initWithString:[stockString stringByReplacingOccurrencesOfString:@"\n" withString:@""]];

        [self addStock:stock];
    }
    
    return self;
}

- (NSString *) componentsJoinedByString:(NSString *) string {
    NSMutableArray *codeArray = [[NSMutableArray alloc]init];
    
    for (MyStock *stock in self.stockArray) {
        [codeArray addObject:stock.codeEx];
    }
    
    return [codeArray componentsJoinedByString:string];
}

- (void) removeAllStock{
    [self.stockArray removeAllObjects];
}

- (void) print {
    for (MyStock *stock in self.stockArray) {
        [stock print];
    }
}

@end
