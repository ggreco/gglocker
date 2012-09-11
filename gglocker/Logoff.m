//
//  Logoff.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "Logoff.h"

@implementation Logoff

-(void)perform{
    UIViewController *src = [self sourceViewController];
    UIViewController *dst = [self destinationViewController];
    
    NSLog(@"Logoff!");
    
    src.view.window.rootViewController = dst;
}

@end
