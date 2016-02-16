//
//  MyWindowController.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/1.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "MyWindowController.h"
#import "Constant.h"

@interface MyWindowController ()

@property (nonatomic) NSTrackingRectTag tag;
@property (nonatomic) CGFloat winWidth;

@end

@implementation MyWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

    NSString *itemPlist = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[@"/" stringByAppendingString:STOCK_ITEMS_PLIST_FILE_NAME]];
    
    StockMonitorItemList *itemList = [[StockMonitorItemList alloc]initWithContentsOfFile:itemPlist];
    
    [self initWinByMonitorItems:itemList];
    
    //设置窗口大小
    NSRect rect = NSMakeRect(200, 200, self.winWidth, STOCK_MIN_WIN_HEIGHT);
    [self.window setFrame:rect display:YES];
    
    //隐藏title bar
    [self.window setStyleMask:NSBorderlessWindowMask];
    
    //没有标题栏后，允许拖动
    [self.window setMovableByWindowBackground:YES];
    
    //设置透明背景，因为view是圆角的
    [self.window setBackgroundColor:[NSColor clearColor]];
        
    //前置窗口
    [self.window makeKeyAndOrderFront:nil];
    [self.window setLevel:NSStatusWindowLevel];
}

- (void)initWinByMonitorItems:(StockMonitorItemList *) monitorItems
{
    CGFloat mainTableWidth = 0.0;
    
    for (StockMonitorItem *item in monitorItems.monitorItemArray) {
        if ([item.name isEqualToString:STOCK_CODE_NAME]) {
            mainTableWidth += STOCK_CODE_WIDTH;
        } else if ([item.name isEqualToString:STOCK_NAME_NAME]){
            mainTableWidth += STOCK_NAME_WIDTH;
        } else if ([item.name isEqualToString:STOCK_PRICE_NAME]){
            mainTableWidth += STOCK_PRICE_WIDTH;
        } else if ([item.name isEqualToString:STOCK_PERCENT_NAME]){
            mainTableWidth += STOCK_PERCENT_WIDTH;
        } else if ([item.name isEqualToString:STOCK_VOL_NAME]){
            mainTableWidth += STOCK_VOL_WIDTH;
        } else if ([item.name isEqualToString:STOCK_AMOUNT_NAME]){
            mainTableWidth += STOCK_AMOUNT_WIDTH;
        } else if ([item.name isEqualToString:STOCK_TIME_NAME]){
            mainTableWidth += STOCK_TIME_WIDTH;
        }
    }
    
    // 2.0 is for beautiful
    self.winWidth = mainTableWidth + 2 * STOCK_MARGIN_X + 2.0;
    
}

@end


