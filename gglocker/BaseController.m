//
//  BaseController.m
//  gglocker
//
//  Created by gabry on 9/13/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "BaseController.h"
#import "NSString_Md5Support.h"

@interface BaseController ()

@end

@implementation BaseController
@synthesize pwd, itemList, dbname, tableview, selectedRow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)changePassword:(NSString*)new_pwd
{
    NSMutableArray *newList = [[NSMutableArray alloc] init];
    
    for (size_t i = 0; i < [self.itemList count]; ++i) {
        NSMutableDictionary *d = [self.itemList objectAtIndex:i];
        NSString *key = [[d allKeys] objectAtIndex:0];
        NSString *value =[d objectForKey:key];
        
        NSMutableDictionary *n = [[NSMutableDictionary alloc] init];
        [n setObject:[[value decrypt:self.pwd] encrypt:new_pwd]
              forKey:[[key decrypt:self.pwd] encrypt:new_pwd] ];
        [newList addObject:n];
    }
    self.itemList = newList;
    self.pwd = new_pwd;
    [self.itemList writeToFile:self.dbname atomically:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableview = nil;
    self.dbname = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/db"];
    NSLog(@"Checking action for DB %@", self.dbname);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.dbname]) {
        itemList = [NSMutableArray arrayWithContentsOfFile:self.dbname];
        NSLog(@"Loaded database with %d items", [itemList count]);
    }
    else {
        itemList = [[NSMutableArray alloc] init];
        NSLog(@"Create new empty database");
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)saveObjects
{
    [self.itemList writeToFile:self.dbname atomically:NO];
    if (self.tableview)
        [self.tableview reloadData];
}

-(void)addObject:(NSMutableDictionary *)dict
{
    NSLog(@"Adding new item with key %@", [[dict allKeys] objectAtIndex:0]);
    [self.itemList addObject:dict];
    [self saveObjects];
}
-(void)delObject:(NSIndexPath *)row
{
    NSLog(@"Deleting object at row %d", row.row);
    [self.itemList removeObjectAtIndex:row.row];
    [self.itemList writeToFile:self.dbname atomically:NO];
    if (self.tableview)
        [self.tableview reloadData];
}

@end
