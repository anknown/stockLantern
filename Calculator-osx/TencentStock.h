//
//  TencentStock.h
//  Calculator-osx
//
//  Created by hanshinan on 16/2/3.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "MyStock.h"
#import "Constant.h"

@interface TencentStock : MyStock <NSCoding>

- (instancetype) initWithString: (NSString *) string;

@end
