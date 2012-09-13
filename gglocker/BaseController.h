//
//  BaseController.h
//  gglocker
//
//  Created by gabry on 9/13/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UINavigationController

@property (nonatomic, strong) NSString *dbname, *pwd;
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) NSIndexPath *selectedRow;
@property (nonatomic, weak) UITableView *tableview;

-(void)addObject:(NSMutableDictionary*)dict;
-(void)delObject:(NSIndexPath *)row;

@end
