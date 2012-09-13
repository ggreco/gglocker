//
//  KeyboardHelper.h
//  gglocker
//
//  Created by gabry on 9/13/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyboardHelper : NSObject    

@property (nonatomic,weak) UIScrollView *scrollview;
@property BOOL keyboardIsShown;

-(KeyboardHelper *)initWithView:(UIScrollView *)view;
@end
