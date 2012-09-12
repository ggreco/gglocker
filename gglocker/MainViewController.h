//
//  MainViewController.h
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) NSIndexPath *selectedRow;
@property (nonatomic, strong) NSString *dbname;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

-(void)addObject:(NSMutableDictionary*)dict;
@end
