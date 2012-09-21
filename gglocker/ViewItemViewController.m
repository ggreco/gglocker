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
#import "KeyboardHelper.h"

@implementation ViewItemViewController
@synthesize textDesc, textContents, buttonModify, helper, scrollview;

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
    self.modifying = NO;
    self.textContents.text = [[dict objectForKey:key] decrypt:b.pwd];
    //NSLog(@"Crypted key:%@, decrypted:%@", key, [key decrypt:b.pwd]);
    self.textDesc.text = [key decrypt:b.pwd];
    [self.textContents setEditable:NO];
    [self.textDesc setEnabled:NO];
    self.helper = [[KeyboardHelper alloc] initWithView:self.scrollview];

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
    [self setTextContents:nil];
    [self setTextDesc:nil];
    [self setButtonModify:nil];
    [self setScrollview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.helper = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textFieldShouldReturn:(UITextField*)textfield
{
    [textfield resignFirstResponder];
    return YES;
}

- (IBAction)modifyClicked:(id)sender {
    if (!self.modifying) {
        self.modifying = YES;
        [self.buttonModify setTitle:@"Accept" forState:UIControlStateNormal];
        [self.textContents setEditable:YES];
        [self.textDesc setEnabled:YES];
        self.title = @"Modify Item";
    }
    else {
        BaseController *b = (BaseController*)self.navigationController;
        NSLog(@"Applying changes to row %d", b.selectedRow.row);
        NSMutableDictionary *dict = [b.itemList objectAtIndex:b.selectedRow.row];
        [dict removeAllObjects];
        [dict setObject:[self.textContents.text encrypt:b.pwd]
                 forKey:[self.textDesc.text encrypt:b.pwd]];
        [b saveObjects];
        
        self.modifying = NO;
        [self.textDesc setEnabled:NO];
        [self.textContents setEditable:NO];
        [self.buttonModify setTitle:@"Modify" forState:UIControlStateNormal];
        self.title = @"View Item";
    }
}
@end
