//
//  MyWindow.m
//  Calculator-osx
//
//  Created by hanshinan on 16/2/3.
//  Copyright © 2016年 hanshinan. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:flag];
    
    if ( self )
    {
        [self setStyleMask:NSBorderlessWindowMask];
        [self setOpaque:NO];
        [self setBackgroundColor:[NSColor clearColor]];
    }
    
    return self;
}


- (void) setContentView:(NSView *)aView
{
    aView.wantsLayer            = YES;
    aView.layer.frame           = aView.frame;
    aView.layer.cornerRadius    = 2.0;
    aView.layer.masksToBounds   = YES;
    
    [super setContentView:aView];
}

@end
