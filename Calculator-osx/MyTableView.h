//
//  MyTableView.h
//  Calculator-osx
//
//  Created by hanshinan on 16/2/6.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Constant.h"
#import "MyTableHeaderCell.h"
#import "StockMonitorItemList.h"

@interface MyTableView : NSTableView

- (instancetype) mainTableByMonitorItems: (StockMonitorItemList *) monitorItems;

@end
