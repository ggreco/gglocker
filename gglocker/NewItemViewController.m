//
//  NewItemViewController.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "NewItemViewController.h"
#import "KeyboardHelper.h"

@implementation NewItemViewController
@synthesize textDetail;
@synthesize scrollview;
@synthesize textDesc;

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
	// Do any additional setup after loading the view.
    self.helper = [[KeyboardHelper alloc] initWithView:self.scrollview];
}

- (void)viewDidUnload
{
    [self setTextDetail:nil];
    [self setTextDesc:nil];
    [self setScrollview:nil];
    [super viewDidUnload];
    self.helper = nil;
    // Release any retained subviews of the main view.
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

@end
