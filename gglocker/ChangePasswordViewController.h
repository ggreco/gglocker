//
//  ChangePasswordViewController.h
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyboardHelper;

@interface ChangePasswordViewController : UIViewController <UITextFieldDelegate> 

@property (weak, nonatomic) IBOutlet UITextField *old_pwd;
@property (weak, nonatomic) IBOutlet UITextField *retype_pwd;
@property (weak, nonatomic) IBOutlet UITextField *thenew_pwd;
- (IBAction)passwordchange_clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) KeyboardHelper *helper;
@end
