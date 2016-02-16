//
//  MyScrollView.h
//  Calculator-osx
//
//  Created by hanshinan on 16/2/10.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyTableView.h"
#import "Constant.h"
#import "StockMonitorItemList.h"

@interface MyScrollView : NSScrollView

@property (nonatomic, strong) MyTableView *tableView;

@property (readwrite) NSInteger tag;

- (instancetype) mainTableByMonitorItems: (StockMonitorItemList *) monitorItems;

@end
