//
//  MyView.h
//  Calculator-osx
//
//  Created by hanshinan on 16/2/3.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StockMonitorItemList.h"

@interface MyView : NSView

@property (readwrite) NSInteger tag;

- (instancetype) thumbnailViewByMonitorItems: (StockMonitorItemList *) monitorItems;

@end
