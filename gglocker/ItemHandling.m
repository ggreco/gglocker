//
//  NewItemAdded.m
//  gglocker
//
//  Created by gabry on 9/12/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "ItemHandling.h"

#import "NewItemViewController.h"
#import "MainViewController.h"

@implementation NewItemAdded

-(void)perform{
    NewItemViewController *src = (NewItemViewController *)[self sourceViewController];
    
    if ([src.textDesc.text length] > 0 &&
        [src.textDetail.text length] > 0) {
        NSLog(@"Adding new item %@", src.textDesc.text);
        
        NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
        [obj setObject:src.textDetail.text forKey:src.textDesc.text];
        [src.previous addObject:obj];
        [src.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WARNING" message:@"You cannot add an item with empty description or content!" delegate:src cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

@end
