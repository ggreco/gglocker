//
//  ViewItemViewController.h
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class KeyboardHelper;

@interface ViewItemViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property BOOL modifying;
@property (weak, nonatomic) IBOutlet UITextField *textDesc;
@property (weak, nonatomic) IBOutlet UITextView *textContents;
@property (weak, nonatomic) IBOutlet UIButton *buttonModify;
- (IBAction)modifyClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (retain, nonatomic) KeyboardHelper *helper;
@end
