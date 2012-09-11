//
//  LoginCheck.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "LoginCheck.h"
#import "LoginViewController.h"
#import "NSString_Md5Support.h"

@implementation LoginCheck

-(void)perform{
    LoginViewController *src = (LoginViewController *)[self sourceViewController];
    UIViewController *dst = [self destinationViewController];
        
    if (src.disk_md5_pwd) {
        if ([src.disk_md5_pwd isEqualToString:[src.pwd.text md5]]) {
            src.view.window.rootViewController = dst;            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WARNING" message:@"Wrong password!" delegate:src cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else {        
        if ([src.pwd.text isEqualToString:src.retype_field.text]) {
            NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            [[src.pwd.text md5] writeToFile:[dir stringByAppendingPathComponent:@"/identity"] atomically:NO encoding:NSUTF8StringEncoding error:nil];
            src.view.window.rootViewController = dst;
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WARNING" message:@"Both field should contain the same password!" delegate:src cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
}
@end
