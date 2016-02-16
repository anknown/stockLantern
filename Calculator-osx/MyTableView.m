//
//  MyTableView.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/6.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "MyTableView.h"


@implementation MyTableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (instancetype) mainTableByMonitorItems: (StockMonitorItemList *) monitorItems {
    for (StockMonitorItem *item in monitorItems.monitorItemArray) {
        if ([item.name isEqualToString:STOCK_CODE_NAME]) {
            NSTableColumn *columnCode = [[NSTableColumn alloc] initWithIdentifier:STOCK_CODE_NAME];
            
            NSTableHeaderCell *cellCode = [[NSTableHeaderCell alloc] init];
            cellCode.stringValue = STOCK_CODE_CH_NAME;
            cellCode.bordered = NO;
            cellCode.alignment = NSTextAlignmentCenter;
            [columnCode setWidth:STOCK_CODE_WIDTH];
            [columnCode setHeaderCell:cellCode];
            
            [self addTableColumn:columnCode];
        } else if ([item.name isEqualToString:STOCK_NAME_NAME]){
            NSTableColumn *columnName = [[NSTableColumn alloc] initWithIdentifier:STOCK_NAME_NAME];
            
            NSTableHeaderCell *cellName = [[NSTableHeaderCell alloc] init];
            cellName.stringValue = STOCK_NAME_CH_NAME;
            cellName.alignment = NSTextAlignmentCenter;
            [columnName setWidth:STOCK_NAME_WIDTH];
            [columnName setHeaderCell:cellName];
            
            [self addTableColumn:columnName];
        } else if ([item.name isEqualToString:STOCK_PRICE_NAME]){
            NSTableColumn *columnPrice = [[NSTableColumn alloc] initWithIdentifier:STOCK_PRICE_NAME];
            
            NSTableHeaderCell *cellPrice = [[NSTableHeaderCell alloc] init];
            cellPrice.stringValue = STOCK_PRICE_CH_NAME;
            cellPrice.alignment = NSTextAlignmentCenter;
            [columnPrice setWidth:STOCK_PRICE_WIDTH];
            [columnPrice setHeaderCell:cellPrice];
            
            [self addTableColumn:columnPrice];
        } else if ([item.name isEqualToString:STOCK_PERCENT_NAME]){
            NSTableColumn *columnPercent = [[NSTableColumn alloc] initWithIdentifier:STOCK_PERCENT_NAME];
            
            NSTableHeaderCell *cellPercent = [[NSTableHeaderCell alloc] init];
            cellPercent.stringValue = STOCK_PERCENT_CH_NAME;
            cellPercent.alignment = NSTextAlignmentCenter;
            [columnPercent setWidth:STOCK_PERCENT_WIDTH];
            [columnPercent setHeaderCell:cellPercent];
            
            [self addTableColumn:columnPercent];
        } else if ([item.name isEqualToString:STOCK_VOL_NAME]){
            NSTableColumn *columnVol = [[NSTableColumn alloc] initWithIdentifier:STOCK_VOL_NAME];
            
            NSTableHeaderCell *cellVol = [[NSTableHeaderCell alloc] init];
            cellVol.stringValue = STOCK_VOL_CH_NAME;
            cellVol.alignment = NSTextAlignmentCenter;
            [columnVol setWidth:STOCK_VOL_WIDTH];
            [columnVol setHeaderCell:cellVol];
            
            [self addTableColumn:columnVol];
        } else if ([item.name isEqualToString:STOCK_AMOUNT_NAME]){
            NSTableColumn *columnAmount = [[NSTableColumn alloc] initWithIdentifier:STOCK_AMOUNT_NAME];
            
            NSTableHeaderCell *cellAmount = [[NSTableHeaderCell alloc] init];
            cellAmount.stringValue = STOCK_AMOUNT_CH_NAME;
            cellAmount.alignment = NSTextAlignmentCenter;
            [columnAmount setWidth:STOCK_AMOUNT_WIDTH];
            [columnAmount setHeaderCell:cellAmount];
            
            [self addTableColumn:columnAmount];
        } else if ([item.name isEqualToString:STOCK_TIME_NAME]){
            NSTableColumn *columnTime = [[NSTableColumn alloc] initWithIdentifier:STOCK_TIME_NAME];
            
            NSTableHeaderCell *cellTime = [[NSTableHeaderCell alloc] init];
            cellTime.stringValue = STOCK_TIME_CH_NAME;
            cellTime.alignment = NSTextAlignmentCenter;
            [columnTime setWidth:STOCK_TIME_WIDTH];
            [columnTime setHeaderCell:cellTime];
            
            [self addTableColumn:columnTime];
        }
    }
    
    NSRect rect = self.frame;
    rect.size.height = STOCK_COL_HEIGHT;
    
    NSTableHeaderView *header = [[NSTableHeaderView alloc] initWithFrame:rect];
    [self setHeaderView:header];
    
    NSSize paddingSize = {0,0};
    [self setIntercellSpacing: paddingSize];
    
    [self setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
        
    return self;
}

@end
