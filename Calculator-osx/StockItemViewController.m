//
//  StockItemViewController.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/11.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "StockItemViewController.h"

@interface StockItemViewController ()

@property (nonatomic) StockMonitorItemList *itemList;
@property (nonatomic, copy) NSString *plist;

@end

@implementation StockItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.plist = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[@"/" stringByAppendingString:STOCK_ITEMS_PLIST_FILE_NAME]];
    
    self.itemList = [[StockMonitorItemList alloc]initWithContentsOfFile:self.plist];
        
    for (StockMonitorItem *item in self.itemList.monitorItemArray) {
        NSButton *button = [self.view viewWithTag:item.index];
        
        if (button != nil) {
            button.state = 1;
        }
    }
    
}

- (IBAction)didApply:(id)sender {
    [self.itemList removeAllStockMonitorItem];
    NSMutableArray *monitorItems = [[NSMutableArray alloc]init];
    
    NSButton *itemButton;
    for (int i = 1; i <= STOCK_TOTAL_IDX; ++i) {
        itemButton = [self.view viewWithTag:i];
        if (itemButton.state == 1) {
            StockMonitorItem *item = [[StockMonitorItem alloc]init];
            switch (i) {
                case STOCK_CODE_IDX:
                    [monitorItems addObject:STOCK_CODE_NAME];
                    item.name = STOCK_CODE_NAME;
                    item.index = STOCK_CODE_IDX;
                    break;
                case STOCK_NAME_IDX:
                    [monitorItems addObject:STOCK_NAME_NAME];
                    item.name = STOCK_NAME_NAME;
                    item.index = STOCK_NAME_IDX;
                    break;
                case STOCK_PRICE_IDX:
                    [monitorItems addObject:STOCK_PRICE_NAME];
                    item.name = STOCK_PRICE_NAME;
                    item.index = STOCK_PRICE_IDX;
                    break;
                case STOCK_PERCENT_IDX:
                    [monitorItems addObject:STOCK_PERCENT_NAME];
                    item.name = STOCK_PERCENT_NAME;
                    item.index = STOCK_PERCENT_IDX;
                    break;
                case STOCK_VOL_IDX:
                    [monitorItems addObject:STOCK_VOL_NAME];
                    item.name = STOCK_VOL_NAME;
                    item.index = STOCK_VOL_IDX;
                    break;
                case STOCK_AMOUNT_IDX:
                    [monitorItems addObject:STOCK_AMOUNT_NAME];
                    item.name = STOCK_AMOUNT_NAME;
                    item.index = STOCK_AMOUNT_IDX;
                    break;
                case STOCK_TIME_IDX:
                    [monitorItems addObject:STOCK_TIME_NAME];
                    item.name = STOCK_TIME_NAME;
                    item.index = STOCK_TIME_IDX;
                    break;
                default:
                    break;
            }
            
            [self.itemList addStockMonitorItem:item];
        }
    }
    
    [self.itemList writeToFile:self.plist];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.itemList.monitorItemArray forKey:STOCK_MONITOR_ITEM_NOTIFICATION_KEY];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STOCK_MONITOR_ITEM_NOTIFICATION object:self userInfo:dict];
    
    [[self.view window] close];
}

@end
