//
//  ChangePasswordViewController.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "nsextensions.h"
#import "BaseController.h"
#import "KeyboardHelper.h"

@interface ChangePasswordViewController ()

@end


@implementation ChangePasswordViewController
@synthesize scrollview;
@synthesize old_pwd;
@synthesize retype_pwd;
@synthesize thenew_pwd;

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

    // register for keyboard notifications
    self.helper = [[KeyboardHelper alloc] initWithView:self.scrollview];
}

-(void)dealloc
{
}

- (void)viewDidUnload
{
    [self setOld_pwd:nil];
    [self setRetype_pwd:nil];
    [self setThenew_pwd:nil];
    [self setScrollview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.helper = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)passwordchange_clicked:(id)sender {
    if ([thenew_pwd.text isEqualToString:retype_pwd.text]) {
        NSString *id = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/identity"];
        NSString *disk_pwd = [NSString stringWithContentsOfFile:id encoding:NSUTF8StringEncoding error:nil];
        if (!disk_pwd || [disk_pwd isEqualToString:[old_pwd.text md5]]) {
             [[thenew_pwd.text md5] writeToFile:id atomically:NO encoding:NSUTF8StringEncoding error:nil];
            BaseController *b = (BaseController *)self.navigationController;
            [b changePassword:thenew_pwd.text];
            [b popViewControllerAnimated:YES];
            UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"" message:@"Password changed." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"WARNING" message:@"The old password is wrong!" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            old_pwd.text = @"";
        }
    }
    else {
        NSLog(@"Mismatch: %@ != %@", thenew_pwd.text, retype_pwd.text);
        UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"WARNING" message:@"Password mismatch in confirmation text!"preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        thenew_pwd.text = @"";
        retype_pwd.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
