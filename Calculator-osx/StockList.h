//
//  StockList.h
//  Calculator-osx
//
//  Created by hanshinan on 16/2/15.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyStock.h"
#import "TencentStock.h"

@interface StockList : NSObject

@property (nonatomic) NSMutableArray *stockArray;

- (instancetype) initWithContentsOfFile: (NSString *)path;
- (instancetype) stockListByTencentString: (NSString *) string;

- (void) writeToFile: (NSString *) path;
- (NSInteger) positionOfStockByCode: (NSString *) code;
- (StockList *) removeStockByCode: (NSString *) code;
- (void) removeAllStock;
- (MyStock *) stockAtIndex: (NSInteger) index;
- (NSInteger) countOfStockList;
- (void) addStock: (MyStock *)stock;
- (void) addStock: (MyStock *)stock automatically: (BOOL) isAutomatic writeToFile: (NSString *) path;
- (StockList *) removeStockByCode: (NSString *) code automatically: (BOOL) isAutomatic writeToFile: (NSString *) path;
- (NSString *) componentsJoinedByString:(NSString *) string;
- (void) print;

@end
