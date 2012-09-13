//
//  NewItemViewController.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "NewItemViewController.h"

@implementation NewItemViewController
@synthesize textDetail;
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
    [self.textDesc setDelegate:self];
    [self.textDetail setDelegate:self];
}

- (void)viewDidUnload
{
    [self setTextDetail:nil];
    [self setTextDesc:nil];
    [super viewDidUnload];
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

-(void) moveUp:(UITextView*)tf up:(BOOL)up
{
    const int d = 80;
    const float speed = 0.3f;
    
    int movement = (up ? -d: d);
    [UIView beginAnimations:@"anim"  context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:speed];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self moveUp:textView up:YES];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self moveUp:textView up:NO];
    return YES;
}

@end
