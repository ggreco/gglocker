//
//  KeyboardHelper.m
//  gglocker
//
//  Created by gabry on 9/13/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "KeyboardHelper.h"

@implementation KeyboardHelper

@synthesize scrollview, keyboardIsShown;

#define kKeyboardAnimationDuration 0.3f

-(KeyboardHelper *)initWithView:(UIScrollView*)view
{
    self = [super init];
    self.keyboardIsShown = NO;
    self.scrollview = view;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:view.window];
    //make contentSize bigger than your scrollSize (you will need to figure out for your own use case)
    self.scrollview.contentSize = CGSizeMake(320, [[UIScreen mainScreen] bounds].size.height - 40 - [UIApplication sharedApplication].statusBarFrame.size.height); // 60 is navigationbar + statusbar
    
    NSLog(@"Initialized helper with scrollview height: %f view: %f screen:%f",
          self.scrollview.contentSize.height,
          [self.scrollview superview].bounds.size.height,
          [[UIScreen mainScreen] bounds].size.height);
    
    for (UIView *view in self.scrollview.subviews) {
        NSLog(@"Changing layout of son %@", view);
        [view setNeedsLayout];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.scrollview.frame;

    viewFrame.size.height += (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:kKeyboardAnimationDuration];
    [self.scrollview setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the UIScrollView if the keyboard is already shown.  This can happen if the user, after fixing editing a UITextField, scrolls the resized UIScrollView to another UITextField and attempts to edit the next UITextField.  If we were to resize the UIScrollView again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown)
        return;
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollview.frame;
    viewFrame.size.height -= (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:kKeyboardAnimationDuration];
    [self.scrollview setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = YES;
}

@end
