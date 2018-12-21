//
//  LoginCheck.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "LoginCheck.h"
#import "LoginViewController.h"
#import "nsextensions.h"
#import "BaseController.h"

@implementation LoginCheck

-(void)perform{
    LoginViewController *src = (LoginViewController *)[self sourceViewController];
    BaseController *dst = (BaseController *)[self destinationViewController];
        
    NSLog(@"Dest: %@", dst);
    if (src.disk_md5_pwd) {
        if ([src.disk_md5_pwd isEqualToString:[src.pwd.text md5]]) {
            dst.pwd = src.pwd.text;
            src.view.window.rootViewController = dst;
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING" message:@"Wrong password!" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [src presentViewController:alert animated:YES completion:nil];
        }
    } else {
        if ([src.pwd.text isEqualToString:src.retype_field.text]) {
            NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            [[src.pwd.text md5] writeToFile:[dir stringByAppendingPathComponent:@"/identity"] atomically:NO encoding:NSUTF8StringEncoding error:nil];
            src.view.window.rootViewController = dst;
            dst.pwd = src.pwd.text;
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING" message:@"Both field should contain the same password!"  preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [src presentViewController:alert animated:YES completion:nil];
        }
    }
}
@end
