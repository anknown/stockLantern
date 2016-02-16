//
//  MyView.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/3.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "MyView.h"
#import "Constant.h"

@interface MyView()

@end

@implementation MyView

@synthesize tag = _tag;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [[NSColor colorWithCalibratedRed:1.0f green:1.0f blue:1.0f alpha:1.0f] set];
    //[[NSColor whiteColor]set];
    NSRectFill(dirtyRect);
}

- (instancetype) thumbnailViewByMonitorItems: (StockMonitorItemList *) monitorItems {
    CGFloat x = STOCK_MARGIN_X;
    CGFloat y = 0;
    CGFloat height = STOCK_COL_HEIGHT;
    NSRect rect = self.frame;

    for (StockMonitorItem *item in monitorItems.monitorItemArray) {
        NSTextField *field = [[NSTextField alloc]init];
        field.drawsBackground = YES;
        field.backgroundColor = [NSColor clearColor];
        field.selectable = NO;
        field.editable = NO;
        field.alignment = NSTextAlignmentRight;
        field.bordered = NO;
        field.textColor = [NSColor redColor];
        
        if ([item.name isEqualToString:STOCK_CODE_NAME]) {
            rect = NSMakeRect(x, y, STOCK_CODE_WIDTH, height);
            field.tag = STOCK_CODE_IDX;
            x += STOCK_CODE_WIDTH;
        } else if ([item.name isEqualToString:STOCK_NAME_NAME]){
            rect = NSMakeRect(x, y, STOCK_NAME_WIDTH, height);
            field.tag = STOCK_NAME_IDX;
            x += STOCK_NAME_WIDTH;
        } else if ([item.name isEqualToString:STOCK_PRICE_NAME]){
            rect = NSMakeRect(x, y, STOCK_PRICE_WIDTH, height);
            field.tag = STOCK_PRICE_IDX;
            x += STOCK_PRICE_WIDTH;
        } else if ([item.name isEqualToString:STOCK_PERCENT_NAME]){
            rect = NSMakeRect(x, y, STOCK_PERCENT_WIDTH, height);
            field.tag = STOCK_PERCENT_IDX;
            x += STOCK_PERCENT_WIDTH;
        } else if ([item.name isEqualToString:STOCK_VOL_NAME]){
            rect = NSMakeRect(x, y, STOCK_VOL_WIDTH, height);
            field.tag = STOCK_VOL_IDX;
            x += STOCK_VOL_WIDTH;
        } else if ([item.name isEqualToString:STOCK_AMOUNT_NAME]){
            rect = NSMakeRect(x, y, STOCK_AMOUNT_WIDTH, height);
            field.tag = STOCK_AMOUNT_IDX;
            x += STOCK_VOL_WIDTH;
        } else if ([item.name isEqualToString:STOCK_TIME_NAME]){
            rect = NSMakeRect(x, y, STOCK_TIME_WIDTH, height);
            field.tag = STOCK_TIME_IDX;
            x += STOCK_TIME_WIDTH;
        }

        [field setFrame:rect];
        
        [self addSubview:field];
    }
    self.tag = STOCK_THUM_ROW_TAG;
    
    return self;
}

@end
