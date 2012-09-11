//
//  LoginViewController.h
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UILabel *pwdlabel;
@property (weak, nonatomic) IBOutlet UILabel *retype_label;
@property (weak, nonatomic) IBOutlet UITextField *retype_field;
@property (weak, nonatomic) IBOutlet UILabel *newuser_label;
@property (retain, nonatomic) NSString *disk_md5_pwd;
@end
