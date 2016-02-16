//
//  MyViewController.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/1.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MyViewController.h"

static NSString * const host = @"http://qt.gtimg.cn/q=";

@interface ViewController()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic) NSTrackingRectTag tag;

@property (nonatomic) CGFloat viewWidth;
@property (nonatomic) CGFloat thumbnailRowWidth;
@property (nonatomic) CGFloat mainTableWidth;
@property (nonatomic) CGFloat mainTableHeight;

@property (nonatomic, copy) NSString *stockPlist;
@property (nonatomic, copy) NSString *itemPlist;

@property (nonatomic) NSMutableArray *monitorItems;

@property (nonatomic) StockList *stockList;
@property (nonatomic) StockMonitorItemList *itemList;

@property (nonatomic, strong) MyView *thumbnailRow;
@property (nonatomic, strong) MyScrollView *mainTable;

@property (atomic) int current;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleMonitorItemNotification:) name:STOCK_MONITOR_ITEM_NOTIFICATION object:nil];
    [nc addObserver:self selector:@selector(handleStockListNotification:) name:STOCK_LIST_NOTIFICATION object:nil];
    
    self.current = 0;
    
    [self.mainTable setHidden:YES];
    
    self.stockPlist = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[@"/" stringByAppendingString:STOCK_PLIST_FILE_NAME]];
    self.itemPlist = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[@"/" stringByAppendingString:STOCK_ITEMS_PLIST_FILE_NAME]];
    
    self.stockList = [[StockList alloc]initWithContentsOfFile:self.stockPlist];
    self.itemList = [[StockMonitorItemList alloc]initWithContentsOfFile:self.itemPlist];
    
    [self initView];
    [self updateView];
    
    self.tag = [self.view addTrackingRect:self.view.bounds owner:self userData:nil assumeInside:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:STOCK_LOAD_INTERVAL target:self selector:@selector(loadTask:) userInfo:nil repeats:YES];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void) mouseEntered:(NSEvent *)theEvent {
    NSWindow *window = [self.view window];
    
    if (window.frame.size.height == STOCK_MIN_VIEW_HEIGHT) {
        [window.contentView removeTrackingRect:self.tag];
        
        [self updateMainTableHeightByStockList];
    
        CGFloat winHeight = STOCK_COL_HEIGHT + STOCK_MARGIN_Y + self.mainTableHeight;
        NSRect rect = NSMakeRect(window.frame.origin.x, window.frame.origin.y - winHeight + STOCK_MIN_VIEW_HEIGHT, self.viewWidth, winHeight);
        [window setFrame:rect display:YES];
        self.tag = [self.view addTrackingRect:self.view.bounds owner:self userData:nil assumeInside:YES];
        
        rect = self.thumbnailRow.frame;
        rect.origin.y = winHeight - STOCK_COL_HEIGHT;
        [self.thumbnailRow setFrame:rect];
        
        rect = self.mainTable.frame;
        rect.origin.y = 0.0f;
        [self.mainTable setFrame:rect];
        
        rect = self.view.frame;
        rect.size.height = winHeight;
        [self.view setFrame:rect];
    }
}

- (void) mouseExited:(NSEvent *)theEvent {
    NSWindow *window = [self.view window];
    
    CGFloat winHeight = STOCK_COL_HEIGHT + STOCK_MARGIN_Y + self.mainTableHeight;
    if (window.frame.size.height == winHeight) {
        [window.contentView removeTrackingRect:self.tag];
        
        NSRect rect = NSMakeRect(window.frame.origin.x, window.frame.origin.y - STOCK_MIN_VIEW_HEIGHT + winHeight, self.viewWidth, STOCK_MIN_VIEW_HEIGHT);
        [window setFrame:rect display:YES];
        
        self.tag = [self.view addTrackingRect:self.view.bounds owner:self userData:nil assumeInside:YES];
        
        rect = self.thumbnailRow.frame;
        rect.origin.y = 0;
        [self.thumbnailRow setFrame:rect];
        
        rect = self.mainTable.frame;
        rect.origin.y = STOCK_COL_HEIGHT + STOCK_MARGIN_Y;
        [self.mainTable setFrame:rect];
    }
}

- (void) loadTask: (NSTimer *)timer {
    [self updateView];
}

- (void) updateTextField: (int) index withStock: (MyStock *) stock {
    NSTextField *field = [self.view viewWithTag:index];

    if (stock == nil) {
        field.stringValue = @"--";
        field.textColor = [NSColor blackColor];
        return ;
    }
    
    float price = [stock.percent floatValue];
    
    if (price > 0) {
        field.textColor = [NSColor redColor];
    } else if (price < 0){
        field.textColor = [NSColor colorWithCalibratedRed:49/255.0 green:139/255.0 blue:64/255.0 alpha:1.0];
    } else {
        field.textColor = [NSColor blackColor];
    }
    
    switch (index) {
        case STOCK_CODE_IDX:
            field.stringValue = stock.code;
            break;
        case STOCK_NAME_IDX:
            field.stringValue = stock.name;
            break;
        case STOCK_TIME_IDX:
            field.stringValue = stock.time;
            break;
        case STOCK_PRICE_IDX:
            field.stringValue = stock.price;
            break;
        case STOCK_PERCENT_IDX:
            field.stringValue = stock.percent;
            break;
        case STOCK_VOL_IDX:
            field.stringValue = stock.vol;
            break;
        case STOCK_AMOUNT_IDX:
            field.stringValue = stock.amount;
            break;
        default:
            break;
    }
}

- (void) updateView {
    if ([self.stockList countOfStockList] == 0) {
        for (StockMonitorItem *item in self.itemList.monitorItemArray) {
            [self updateTextField:(int)item.index withStock:nil];
        }
        
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);

        NSString *url = [host stringByAppendingString:[self.stockList componentsJoinedByString:@","]];
        NSURL *URL = [NSURL URLWithString:url];
        NSError * error;
        NSString * data = [NSString stringWithContentsOfURL:URL encoding:gbkEncoding error:&error];
        
        if (error != nil) {
            NSLog(@"network error!");
        }
        
        if (data != nil && ![data isEqualToString:@"pv_none_match=1;"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.current + 1 >= [self.stockList countOfStockList]) {
                    self.current = 0;
                }
                MyStock *stock = [[self.stockList stockListByTencentString:data]stockAtIndex:self.current];
                
                for (StockMonitorItem *item in self.itemList.monitorItemArray) {
                    [self updateTextField:(int)item.index withStock:stock];
                }

                if (self.current + 1 >= [self.stockList countOfStockList]) {
                    self.current = 0;
                } else {
                    self.current ++;
                }
                
                [[self.mainTable tableView] reloadData];
            });
        } else {
            NSLog(@"error when loading data:%@", error);
        }
    });
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.stockList countOfStockList];
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return NO;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return STOCK_TBL_CELL_HEIGHT;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTextField *field = [tableView makeViewWithIdentifier:@"MyCell" owner:self];
    if (field == nil) {
        field = [[NSTextField alloc]init];
        field.identifier = @"MyCell";
    }
    
    field.drawsBackground = YES;
    field.backgroundColor = [NSColor clearColor];
    field.selectable = NO;
    field.editable = NO;
    field.alignment = NSTextAlignmentRight;
    field.bordered = NO;
    field.font = [NSFont fontWithName:@"STHeitiTC-Light" size:12];
    
    MyStock *stock = [self.stockList stockAtIndex:row];
    
    if ([stock.percent hasPrefix:@"-"]) {
        field.textColor = [NSColor colorWithCalibratedRed:49/255.0 green:139/255.0 blue:64/255.0 alpha:1.0];
    } else if ([stock.percent isEqualToString:@"0.00%"]){
        field.textColor = [NSColor blackColor];
    } else {
        field.textColor = [NSColor redColor];
    }
    
    CGFloat height = STOCK_COL_HEIGHT;
    if ([STOCK_CODE_NAME isEqualToString:tableColumn.identifier]) {
        field.stringValue = stock.code;
        NSRect rect = NSMakeRect(0, 0, STOCK_CODE_WIDTH, height);
        [field setFrame:rect];
    } else if ([STOCK_NAME_NAME isEqualToString:tableColumn.identifier]){
        field.stringValue = stock.name;
        NSRect rect = NSMakeRect(0, 0, STOCK_NAME_WIDTH, height);
        [field setFrame:rect];
    } else if ([STOCK_TIME_NAME isEqualToString:tableColumn.identifier]){
        field.stringValue = stock.time;
        NSRect rect = NSMakeRect(0, 0, STOCK_TIME_WIDTH, height);
        [field setFrame:rect];
    } else if ([STOCK_PRICE_NAME isEqualToString:tableColumn.identifier]){
        field.stringValue = stock.price;
        NSRect rect = NSMakeRect(0, 0, STOCK_PRICE_WIDTH, height);
        [field setFrame:rect];
    } else if ([STOCK_PERCENT_NAME isEqualToString:tableColumn.identifier]){
        field.stringValue = stock.percent;
        NSRect rect = NSMakeRect(0, 0, STOCK_PERCENT_WIDTH, height);
        [field setFrame:rect];
    } else if ([STOCK_VOL_NAME isEqualToString:tableColumn.identifier]){
        field.stringValue = stock.vol;
        NSRect rect = NSMakeRect(0, 0, STOCK_VOL_WIDTH, height);
        [field setFrame:rect];
    } else if ([STOCK_AMOUNT_NAME isEqualToString:tableColumn.identifier]){
        field.stringValue = stock.amount;
        NSRect rect = NSMakeRect(0, 0, STOCK_AMOUNT_WIDTH, height);
        [field setFrame:rect];
    }
    
    return field;
}

- (void)handleMonitorItemNotification:(NSNotification *) notification{
    self.itemList.monitorItemArray = [[notification userInfo] objectForKey:STOCK_MONITOR_ITEM_NOTIFICATION_KEY];
    [self updateWidthByMonitorItems];
}

- (void)handleStockListNotification:(NSNotification *) notification{
    self.stockList.stockArray = [[notification userInfo] objectForKey:STOCK_LIST_NOTIFICATION_KEY];
    //[self.stockList print];
    [self updateView];
    [[self.mainTable tableView]reloadData];
}

- (void) initView {
    self.mainTableWidth = 0.0;
    self.mainTableHeight = [self.stockList countOfStockList] * STOCK_TBL_CELL_HEIGHT + STOCK_TBL_HEADER_HEIGHT - 5.0;

    for (StockMonitorItem *item in self.itemList.monitorItemArray) {
        if ([item.name isEqualToString:STOCK_CODE_NAME]) {
            self.mainTableWidth += STOCK_CODE_WIDTH;
        } else if ([item.name isEqualToString:STOCK_NAME_NAME]){
            self.mainTableWidth += STOCK_NAME_WIDTH;
        } else if ([item.name isEqualToString:STOCK_PRICE_NAME]){
            self.mainTableWidth += STOCK_PRICE_WIDTH;
        } else if ([item.name isEqualToString:STOCK_PERCENT_NAME]){
            self.mainTableWidth += STOCK_PERCENT_WIDTH;
        } else if ([item.name isEqualToString:STOCK_VOL_NAME]){
            self.mainTableWidth += STOCK_VOL_WIDTH;
        } else if ([item.name isEqualToString:STOCK_AMOUNT_NAME]){
            self.mainTableWidth += STOCK_AMOUNT_WIDTH;
        } else if ([item.name isEqualToString:STOCK_TIME_NAME]){
            self.mainTableWidth += STOCK_TIME_WIDTH;
        }
    }
    
    self.thumbnailRowWidth = self.mainTableWidth + STOCK_MARGIN_X;
    
    // 2.0 is for beautiful
    self.viewWidth = self.mainTableWidth + 2 * STOCK_MARGIN_X + 2.0;
    
    NSRect rect = NSMakeRect(200, 200, self.viewWidth, STOCK_COL_HEIGHT);

    NSWindow *window = [self.view window];
    [window setFrame:rect display:YES];
    
    rect = NSMakeRect(STOCK_MARGIN_X, 0, self.thumbnailRowWidth, STOCK_MIN_VIEW_HEIGHT);
    self.thumbnailRow = [[[MyView alloc] initWithFrame:rect] thumbnailViewByMonitorItems:self.itemList];
    [self.view addSubview:self.thumbnailRow];

    rect = NSMakeRect(2 * STOCK_MARGIN_X, STOCK_COL_HEIGHT +  STOCK_MARGIN_Y, self.mainTableWidth, self.mainTableHeight);
    self.mainTable = [[[MyScrollView alloc] initWithFrame:rect] mainTableByMonitorItems:self.itemList];
    [self.mainTable.tableView setDelegate:self];
    [self.mainTable.tableView setDataSource:self];
    [self.view addSubview: self.mainTable];
    
    rect = NSMakeRect(STOCK_MARGIN_X, 0, self.viewWidth, STOCK_MIN_VIEW_HEIGHT);;
    [self.view setFrame:rect];
    [self.view setBounds:rect];
    [self.view setNeedsDisplay:YES];
}

- (void) updateWidthByMonitorItems {
    CGFloat mainTableWidth = self.mainTableWidth;
    
    self.mainTableWidth = 0.0;
    self.mainTableHeight = [self.stockList countOfStockList] * STOCK_TBL_CELL_HEIGHT + STOCK_TBL_HEADER_HEIGHT - 5.0;
    
    for (StockMonitorItem *item in self.itemList.monitorItemArray) {
        if ([item.name isEqualToString:STOCK_CODE_NAME]) {
            self.mainTableWidth += STOCK_CODE_WIDTH;
        } else if ([item.name isEqualToString:STOCK_NAME_NAME]){
            self.mainTableWidth += STOCK_NAME_WIDTH;
        } else if ([item.name isEqualToString:STOCK_PRICE_NAME]){
            self.mainTableWidth += STOCK_PRICE_WIDTH;
        } else if ([item.name isEqualToString:STOCK_PERCENT_NAME]){
            self.mainTableWidth += STOCK_PERCENT_WIDTH;
        } else if ([item.name isEqualToString:STOCK_VOL_NAME]){
            self.mainTableWidth += STOCK_AMOUNT_WIDTH;
        } else if ([item.name isEqualToString:STOCK_AMOUNT_NAME]){
            self.mainTableWidth += STOCK_AMOUNT_WIDTH;
        } else if ([item.name isEqualToString:STOCK_TIME_NAME]){
            self.mainTableWidth += STOCK_TIME_WIDTH;
        }
    }
    
    self.thumbnailRowWidth = self.mainTableWidth + STOCK_MARGIN_X;
    
    // 2.0 is for beautiful
    self.viewWidth = self.mainTableWidth + 2 * STOCK_MARGIN_X + 2.0;
    
    if (mainTableWidth != self.mainTableWidth) {
        NSWindow *window = [self.view window];
        NSRect rect = window.frame;
        rect.size.width = self.viewWidth;
        [window setFrame:rect display:YES animate:YES];
        
        rect = self.view.frame;
        rect.size.width = self.viewWidth;
        [self.view setFrame:rect];
        
        rect = self.thumbnailRow.frame;
        rect.size.width = self.thumbnailRowWidth;
        [self.thumbnailRow setFrame:rect];
        [[self.view viewWithTag:STOCK_THUM_ROW_TAG] removeFromSuperview];
        self.thumbnailRow = [[[MyView alloc] initWithFrame:rect] thumbnailViewByMonitorItems:self.itemList];
        [self.view addSubview:self.thumbnailRow];
        
        rect = self.mainTable.frame;
        rect.size.width = self.mainTableWidth;
        rect.size.height = self.mainTableHeight;
        [self.mainTable setFrame:rect];
        [[self.view viewWithTag:STOCK_MAIN_TBL_TAG] removeFromSuperview];
        self.mainTable = [[[MyScrollView alloc] initWithFrame:rect] mainTableByMonitorItems:self.itemList];
        [self.mainTable.tableView setDelegate:self];
        [self.mainTable.tableView setDataSource:self];
        
        [self.view addSubview: self.mainTable];
    }
    
}

- (void) updateMainTableHeightByStockList{
    self.mainTableHeight = [self.stockList countOfStockList] * STOCK_TBL_CELL_HEIGHT + STOCK_TBL_HEADER_HEIGHT - 5.0;
    
    NSRect rect = self.mainTable.frame;
    rect.size.height = self.mainTableHeight;
    [self.mainTable setFrame:rect];
}

@end
