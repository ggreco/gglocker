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
#import "BaseController.h"
#import "NSString_Md5Support.h"

@implementation NewItemAdded

-(void)perform{
    NewItemViewController *src = (NewItemViewController *)[self sourceViewController];
    
    if ([src.textDesc.text length] > 0 &&
        [src.textDetail.text length] > 0) {
        BaseController *b = (BaseController*)src.navigationController;

        NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
        [obj setObject:[src.textDetail.text encrypt:b.pwd]
                forKey:[src.textDesc.text   encrypt:b.pwd] ];
        [b addObject:obj];
        [b popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WARNING" message:@"You cannot add an item with empty description or content!" delegate:src cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

@end

@implementation ItemDeleted

-(void)perform {
    UIViewController *src = [self sourceViewController];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Item" message:@"Are you sure you want to delete this item?" delegate:src cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}

@end