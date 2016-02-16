//
//  MyStock.h
//  Calculator-osx
//
//  Created by hanshinan on 16/2/3.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

enum error {
    ERR_INVALID_INPUT,
};

@interface MyStock : NSObject <NSCoding>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *percent;
@property (nonatomic, copy) NSString *vol;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *abbreviate;
@property (nonatomic, copy) NSString *codeEx;

@property (nonatomic) int status;

- (void) print;

@end
