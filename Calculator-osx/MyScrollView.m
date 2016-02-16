//
//  MyScrollView.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/10.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView ()

@end

@implementation MyScrollView

@synthesize tag = _tag;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (instancetype) mainTableByMonitorItems: (StockMonitorItemList *) monitorItems {
    NSRect rect = self.frame;
    self.tableView = [[[MyTableView alloc] initWithFrame:rect] mainTableByMonitorItems:monitorItems];
    [self setDocumentView:self.tableView];
    [self setHasVerticalScroller:YES];
    
    self.tag = STOCK_MAIN_TBL_TAG;
    
    return self;
}

@end
