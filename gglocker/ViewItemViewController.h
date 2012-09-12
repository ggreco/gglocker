//
//  ViewItemViewController.h
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewItemViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property (weak, nonatomic) IBOutlet UITextView *textContents;
@property (strong, nonatomic) NSString *key, *value;
@end
