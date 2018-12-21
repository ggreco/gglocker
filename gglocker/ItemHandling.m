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
#import "nsextensions.h"

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
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING" message:@"You cannot add an item with empty description or content!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [src presentViewController:alert animated:YES completion:nil];
    }
}

@end

@implementation ItemDeleted

-(void)perform {
    UIViewController *src = [self sourceViewController];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete Item" message:@"Are you sure you want to delete this item?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        BaseController *b = (BaseController*)src.navigationController;
        [b delObject:b.selectedRow];
        [b popViewControllerAnimated:YES];
    }]];
    [src presentViewController:alert animated:YES completion:nil];
}

@end
