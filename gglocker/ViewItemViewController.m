//
//  ViewItemViewController.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "ViewItemViewController.h"
#import "MainViewController.h"
#import "BaseController.h"
#import "NSString_Md5Support.h"

@implementation ViewItemViewController
@synthesize labelDesc, textContents;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    BaseController *b = (BaseController*)self.navigationController;
    NSMutableDictionary *dict = [b.itemList objectAtIndex:b.selectedRow.row];
    NSString *key = [[dict allKeys] objectAtIndex:0];
	// Do any additional setup after loading the view.
    //NSLog(@"Crypted body:%@, decrypted:%@", [dict objectForKey:key], [[dict objectForKey:key] decrypt:b.pwd]);
    self.textContents.text = [[dict objectForKey:key] decrypt:b.pwd];
    //NSLog(@"Crypted key:%@, decrypted:%@", key, [key decrypt:b.pwd]);
    self.labelDesc.text = [key decrypt:b.pwd];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        BaseController *b = (BaseController*)self.navigationController;
        [b delObject:b.selectedRow];
        [b popViewControllerAnimated:YES];
    }
}

- (void)viewDidUnload
{
    [self setLabelDesc:nil];
    [self setTextContents:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
