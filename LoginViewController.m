//
//  LoginViewController.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize pwd;
@synthesize pwdlabel;
@synthesize retype_label;
@synthesize retype_field;
@synthesize newuser_label;
@synthesize disk_md5_pwd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)editCompleted:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.pwd setDelegate:self];
    [self.retype_field setDelegate:self];
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    disk_md5_pwd = [NSString stringWithContentsOfFile:[dir stringByAppendingPathComponent:@"/identity"] encoding:NSUTF8StringEncoding error:nil];
    
    if (disk_md5_pwd) {
        [self.retype_field setHidden:YES];
        [self.newuser_label setHidden:YES];
        [self.retype_label setHidden:YES];
    }
    else {
        NSLog(@"Starting as new user!");
        [self.retype_field setHidden:NO];
        [self.newuser_label setHidden:NO];
        [self.retype_label setHidden:NO];
    }
}

-(void) moveUp:(UITextField*)tf up:(BOOL)up
{
    const int d = 160;
    const float speed = 0.5f;
    
    int movement = (up ? -d: d);
    [UIView beginAnimations:@"anim"  context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:speed];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void)textFieldDidBeginEditing:(UITextField*)tf
{
    if ([tf isEqual:self.retype_field])
        [self moveUp:tf up:YES];
}
-(void)textFieldDidEndEditing:(UITextField*)tf
{
    if ([tf isEqual:self.retype_field])
        [self moveUp:tf up:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textfield
{
    [textfield resignFirstResponder];
    if (disk_md5_pwd) {
        [self performSegueWithIdentifier:@"LoginCheck" sender:self];
    }
    return YES;
}

- (void)viewDidUnload
{
    [self setPwd:nil];
    [self setPwdlabel:nil];
    [self setRetype_label:nil];
    [self setRetype_field:nil];
    [self setNewuser_label:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
