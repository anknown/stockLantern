//
//  StockListViewController.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/11.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "StockListViewController.h"

const NSString * const host = @"http://suggest3.sinajs.cn/suggest/type=&key=";

@interface StockListViewController ()

@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (nonatomic, weak) IBOutlet NSSearchField *searchField;
@property (nonatomic, weak) IBOutlet NSTableView *suggestView;

@property (nonatomic) NSMutableArray *searchStockList;
@property (nonatomic, copy) NSString *plist;
@property (nonatomic) StockList *stockList;
@property (atomic) int order;

@end

@implementation StockListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    // you need to hide scroll view
    self.order = 0;
    self.plist = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[@"/" stringByAppendingString:STOCK_PLIST_FILE_NAME]];
    self.stockList = [[StockList alloc]initWithContentsOfFile:self.plist];
    
    self.searchField.sendsSearchStringImmediately = YES;
    
    [[[self.suggestView superview] superview] setHidden:YES];
    self.suggestView.tag = STOCK_SUGG_TBL_TAG;
    self.suggestView.dataSource = self;
    self.suggestView.delegate = self;
    
    self.tableView.tag = STOCK_LIST_TBL_TAG;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void) hideSuggestView: (NSTimer *)timer {
    self.suggestView.hidden = YES;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (tableView.tag == STOCK_LIST_TBL_TAG) {
        return [self.stockList countOfStockList];
    } else if (tableView.tag == STOCK_SUGG_TBL_TAG) {
        NSRect rect = [[self.suggestView superview]superview].frame;
        CGFloat winHeight = self.view.frame.size.height;

        if (self.searchStockList.count > STOCK_SEARCH_TBL_COUNT) {
            rect.size.height = STOCK_SEARCH_TBL_COUNT * (STOCK_TBL_CELL_HEIGHT + 2 * STOCK_TBL_LINE_HEIGHT) + STOCK_TBL_MARGIN_Y;
            rect.origin.y = winHeight - rect.size.height - 30;
            [[[self.suggestView superview]superview] setFrame:rect];
            return STOCK_SEARCH_TBL_COUNT;
        }
        
        if (self.searchStockList.count == 0) {
            rect.size.height = 0;
            [[[self.suggestView superview]superview] setFrame:rect];
            return 0;
        }
        
        rect.size.height = self.searchStockList.count * (STOCK_TBL_CELL_HEIGHT + 2 * STOCK_TBL_LINE_HEIGHT) + STOCK_TBL_MARGIN_Y;
        rect.origin.y = winHeight - rect.size.height - 30;
        [[[self.suggestView superview]superview] setFrame:rect];
        return self.searchStockList.count;
    }
    
    return 0;
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return NO;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    if (tableView.tag == STOCK_LIST_TBL_TAG){
        return STOCK_TBL_CELL_HEIGHT;
    } else if (tableView.tag == STOCK_SUGG_TBL_TAG){
        return STOCK_TBL_CELL_HEIGHT;
    }
    
    return STOCK_TBL_CELL_HEIGHT;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (tableView.tag == STOCK_LIST_TBL_TAG) {
        MyStock *stock = [self.stockList stockAtIndex:row];
        
        NSTextField *field = [[NSTextField alloc] init];
        field.bordered = NO;
        field.editable = NO;
        if ([tableColumn.identifier isEqualToString:@"code"]) {
            field.stringValue = stock.code;
            return field;
        } else if ([tableColumn.identifier isEqualToString:@"name"]) {
            field.stringValue = stock.name;
            return field;
            
        } else if ([tableColumn.identifier isEqualToString:@"operator"]) {
            NSTableCellView *view = [[NSTableCellView alloc]init];
            NSButton *button = [[NSButton alloc] init];
            NSRect rect = NSMakeRect(0, 0, 50, 20);
            [button setBordered:NO];
            [button setTitle:@"删除"];
            [button setFrame:rect];
            [button setTarget:self];
            [button setIdentifier:stock.code];
            [button setAction:@selector(didDeleteStock:)];
            [button setFont:[NSFont systemFontOfSize:11.0]];
            
            [view addSubview:button];
            return view;
        }
    } else if (tableView.tag == STOCK_SUGG_TBL_TAG){
        NSTableCellView *view = [[NSTableCellView alloc]init];
        
        MyStock *stock = self.searchStockList[row];

        NSTextField *abbreviate = [[NSTextField alloc]initWithFrame:NSMakeRect(0, 0, STOCK_AB_NAME_WIDTH, STOCK_COL_HEIGHT)];
        abbreviate.stringValue = stock.abbreviate;
        abbreviate.bordered = NO;
        abbreviate.backgroundColor = [NSColor clearColor];
        abbreviate.editable = NO;
        abbreviate.tag = STOCK_AB_NAME_IDX;
        
        NSTextField *code = [[NSTextField alloc]initWithFrame:NSMakeRect(STOCK_AB_NAME_WIDTH + 10, 0, STOCK_CODE_WIDTH + 10, STOCK_COL_HEIGHT)];
        code.stringValue = stock.code;
        code.bordered = NO;
        code.backgroundColor = [NSColor clearColor];
        code.editable = NO;
        code.tag = STOCK_CODE_IDX;
        
        NSTextField *name = [[NSTextField alloc]initWithFrame:NSMakeRect(STOCK_CODE_WIDTH + STOCK_AB_NAME_WIDTH + 20, 0, STOCK_NAME_WIDTH, STOCK_COL_HEIGHT)];
        name.stringValue = stock.name;
        name.bordered = NO;
        name.backgroundColor = [NSColor clearColor];
        name.editable = NO;
        name.tag = STOCK_NAME_IDX;
        
        NSTextField *codeEx = [[NSTextField alloc]initWithFrame:NSMakeRect(STOCK_NAME_WIDTH + STOCK_AB_NAME_WIDTH + STOCK_NAME_WIDTH, 0, STOCK_CODE_EX_WIDTH, STOCK_COL_HEIGHT)];
        codeEx.stringValue = stock.codeEx;
        codeEx.bordered = NO;
        codeEx.editable = NO;
        codeEx.backgroundColor = [NSColor clearColor];
        codeEx.hidden = YES;
        codeEx.tag = STOCK_CODE_EX_IDX;

        [view addSubview:abbreviate];
        [view addSubview:code];
        [view addSubview:name];
        [view addSubview:codeEx];
        
        return view;
    }

    
    return nil;
}

- (void) didDeleteStock: (id)sender {
    NSButton *button = sender;
    
    [self.stockList removeStockByCode:button.identifier automatically:YES writeToFile:self.plist];
    [self.tableView reloadData];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.stockList.stockArray forKey:STOCK_LIST_NOTIFICATION_KEY];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STOCK_LIST_NOTIFICATION object:self userInfo:dict];
}

- (IBAction)didSearchStock:(id)sender {
    if (![self.searchField.stringValue isEqualToString:@""]) {
        NSString *url = [host stringByAppendingString:self.searchField.stringValue.lowercaseString];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            NSURL *URL = [NSURL URLWithString:url];
            NSError * error;
            NSString * data = [NSString stringWithContentsOfURL:URL encoding:gbkEncoding error:&error];
            int order = self.order + 1;
            
            if (error != nil) {
                NSLog(@"network error!");
            }
            
            if (data != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.searchStockList = [[[SinaStock alloc]init] stockListWithString:data];
                    [[[self.suggestView superview]superview] setHidden:NO];

                    if (order > self.order) {
                        self.order = order;
                        [self.suggestView reloadData];
                    }
                });
            } else {
                NSLog(@"error when loading data:%@", error);
            }
            
        });

    } else {
        if (self.searchStockList.count > 0) {
            [self.searchStockList removeAllObjects];
            [self.suggestView reloadData];
        }
    }
}

- (IBAction)didClick:(id)sender {
    MyStock *stock = [[MyStock alloc]init];
    
    NSInteger row = self.suggestView.clickedRow;
    
    NSTableCellView *cell = [sender subviews][row];
    
    NSTextField *name = [cell viewWithTag:STOCK_NAME_IDX];
    NSTextField *code = [cell viewWithTag:STOCK_CODE_IDX];
    NSTextField *codeEx = [cell viewWithTag:STOCK_CODE_EX_IDX];
    
    stock.name = name.stringValue;
    stock.code = code.stringValue;
    stock.codeEx = codeEx.stringValue;

    if ([self.stockList positionOfStockByCode:stock.code] < 0) {
        [self.stockList addStock:stock automatically:YES writeToFile:self.plist];
        [self.tableView reloadData];
    }
    
    if (self.searchStockList.count > 0) {
        [self.searchField setStringValue:@""];
        [self.searchStockList removeAllObjects];
        [self.suggestView reloadData];
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.stockList.stockArray forKey:STOCK_LIST_NOTIFICATION_KEY];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STOCK_LIST_NOTIFICATION object:self userInfo:dict];
}

@end
