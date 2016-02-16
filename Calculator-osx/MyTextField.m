//
//  MyTextField.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/10.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "MyTextField.h"
#import "Constant.h"

@implementation MyTextField

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (instancetype) textFieldByIndex: (int) index {
    self.drawsBackground = YES;
    self.backgroundColor = [NSColor clearColor];
    self.selectable = NO;
    self.editable = NO;
    self.alignment = NSTextAlignmentRight;
    self.bordered = NO;
    self.textColor = [NSColor blackColor];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = STOCK_COL_HEIGHT;
    
    NSRect rect;
    switch (index) {
        case STOCK_CODE_IDX:
            rect = NSMakeRect(x, y, STOCK_CODE_WIDTH, height);
            self.tag = STOCK_CODE_IDX;
            x += STOCK_CODE_WIDTH;
            
            self.stringValue = @"600610";
            break;
        case STOCK_NAME_IDX:
            rect = NSMakeRect(x, y, STOCK_NAME_WIDTH, height);
            self.tag = STOCK_NAME_IDX;
            x += STOCK_NAME_WIDTH;
            
            self.stringValue = @"中毅达";
            break;
        case STOCK_TIME_IDX:
            rect = NSMakeRect(x, y, STOCK_TIME_WIDTH, height);
            self.tag = STOCK_TIME_IDX;
            x += STOCK_TIME_WIDTH;
            
            self.stringValue = @"2016-01-02 21:00:09";
            break;
        case STOCK_PRICE_IDX:
            rect = NSMakeRect(x, y, STOCK_PRICE_WIDTH, height);
            self.tag = STOCK_PRICE_IDX;
            x += STOCK_PRICE_WIDTH;
            
            self.stringValue = @"18.61";
            break;
        case STOCK_PERCENT_IDX:
            rect = NSMakeRect(x, y, STOCK_PERCENT_WIDTH, height);
            self.tag = STOCK_PERCENT_IDX;
            x += STOCK_PERCENT_WIDTH;
            
            self.stringValue = @"-4.32%";
            break;
        case STOCK_VOL_IDX:
            rect = NSMakeRect(x, y, STOCK_VOL_WIDTH, height);
            self.tag = STOCK_VOL_IDX;
            x += STOCK_VOL_WIDTH;
            
            self.stringValue = @"82.45万手";
            break;
        case STOCK_AMOUNT_IDX:
            rect = NSMakeRect(x, y, STOCK_AMOUNT_WIDTH, height);
            self.tag = STOCK_AMOUNT_IDX;
            x += STOCK_VOL_WIDTH;
            
            self.stringValue = @"82.74亿";
            break;
        default:
            break;
    }
    
    [self setFrame:rect];
    
    return self;
}

@end
