//
//  StockMonitorItemList.h
//  Calculator-osx
//
//  Created by hanshinan on 16/2/15.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockMonitorItem.h"


@interface StockMonitorItemList : NSObject

@property (nonatomic) NSMutableArray *monitorItemArray;


- (instancetype) initWithContentsOfFile: (NSString *)path;
- (void) writeToFile: (NSString *) path;
- (void) addStockMonitorItem: (StockMonitorItem *) monitorItem;
- (NSInteger) positionOfStockMonitorItemByIndex: (NSInteger) index;
- (void) removeAllStockMonitorItem;

@end
