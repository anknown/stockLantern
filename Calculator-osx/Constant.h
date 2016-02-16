//
//  Constant.h
//  Calculator-osx
//
//  Created by hanshinan on 16/2/3.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

static const int STOCK_LOAD_INTERVAL = 3;
static const int STOCK_HIDE_SUGG_INTERVAL = 5;

static const int STOCK_TOTAL_IDX = 8;

static const int STOCK_CODE_IDX = 1;
static const int STOCK_CODE_WIDTH = 50;
static NSString * const STOCK_CODE_NAME = @"code";
static NSString * const STOCK_CODE_CH_NAME = @"代码";
static const int STOCK_NAME_IDX = 2;
static const int STOCK_NAME_WIDTH = 56;
static NSString * const STOCK_NAME_NAME = @"name";
static NSString * const STOCK_NAME_CH_NAME = @"股票名称";
static const int STOCK_PRICE_IDX = 3;
static const int STOCK_PRICE_WIDTH = 53;
static NSString * const STOCK_PRICE_NAME = @"price";
static NSString * const STOCK_PRICE_CH_NAME = @"价格";
static const int STOCK_PERCENT_IDX = 4;
static const int STOCK_PERCENT_WIDTH = 54;
static NSString * const STOCK_PERCENT_NAME = @"percent";
static NSString * const STOCK_PERCENT_CH_NAME = @"涨跌幅";
static const int STOCK_VOL_IDX = 5;
static const int STOCK_VOL_WIDTH = 80;
static NSString * const STOCK_VOL_NAME = @"vol";
static NSString * const STOCK_VOL_CH_NAME = @"成交量";
static const int STOCK_AMOUNT_IDX = 6;
static const int STOCK_AMOUNT_WIDTH = 67;
static NSString * const STOCK_AMOUNT_NAME = @"amount";
static NSString * const STOCK_AMOUNT_CH_NAME = @"成交额";

static const int STOCK_TIME_IDX = 8;
static const int STOCK_TIME_WIDTH = 56;
static NSString * const STOCK_TIME_NAME = @"time";
static NSString * const STOCK_TIME_CH_NAME = @"当前时间";
static const int STOCK_AB_NAME_IDX = 9;
static const int STOCK_AB_NAME_WIDTH = 62;
static NSString * const STOCK_AB_NAME_NAME = @"abbreviate";
static NSString * const STOCK_AB_NAME_CH_NAME = @"缩写";
//stock name with market, e.g. SH600610
static const int STOCK_CODE_EX_IDX = 10;
static const int STOCK_CODE_EX_WIDTH = 62;
static NSString * const STOCK_CODE_EX_NAME = @"codeex";
static NSString * const STOCK_CODE_EX_CH_NAME = @"扩展代码";


static NSString * const STOCK_MONITOR_ITEM_NOTIFICATION = @"monitor_item_notification";
static NSString * const STOCK_MONITOR_ITEM_NOTIFICATION_KEY = @"monitor_item";
static NSString * const STOCK_LIST_NOTIFICATION = @"stock_list_notification";
static NSString * const STOCK_LIST_NOTIFICATION_KEY = @"stock_list";

static NSString * const STOCK_MON_ITEM_NAME_KEY = @"monitorName";
static NSString * const STOCK_MON_ITEM_IDX_KEY = @"monitorIdx";

static const CGFloat STOCK_COL_HEIGHT = 17.0;
static const CGFloat STOCK_MARGIN_Y = 3.0;
static const CGFloat STOCK_MARGIN_X = 5.0;
static const CGFloat STOCK_MIN_VIEW_HEIGHT = STOCK_COL_HEIGHT;
static const CGFloat STOCK_MAX_VIEW_HEIGHT = STOCK_MIN_VIEW_HEIGHT * 11 + STOCK_MARGIN_Y;
static const CGFloat STOCK_MIN_WIN_HEIGHT = STOCK_MIN_VIEW_HEIGHT;
static const CGFloat STOCK_MAX_WIN_HEIGHT = STOCK_MAX_VIEW_HEIGHT;
static const CGFloat STOCK_TBL_CELL_HEIGHT = 17.0;
static const CGFloat STOCK_TBL_HEADER_HEIGHT = 23.0;
static const CGFloat STOCK_TBL_MARGIN_Y = 3.0;
static const CGFloat STOCK_TBL_LINE_HEIGHT = 1.0;

static const int STOCK_SEARCH_TBL_COUNT = 5;

static const int STOCK_THUM_ROW_TAG = 1000;
static const int STOCK_MAIN_TBL_TAG = 1001;
static const int STOCK_SUGG_TBL_TAG = 1002;
static const int STOCK_LIST_TBL_TAG = 1003;

static NSString * const STOCK_PLIST_FILE_NAME = @"stocklist.plist";
static NSString * const STOCK_ITEMS_PLIST_FILE_NAME = @"stockitems.plist";

enum status{
    STOCK_UP = 0,
    STOCK_DOWN = 1,
    STOCK_FLAT = 2
};

#endif /* Constant_h */
