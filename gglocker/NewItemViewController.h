//
//  NewItemViewController.h
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyboardHelper;
@class MainViewController;

@interface NewItemViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textDetail;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *textDesc;
@property (retain, nonatomic) KeyboardHelper *helper;
@end
