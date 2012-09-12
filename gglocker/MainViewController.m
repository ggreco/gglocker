//
//  MainViewController.m
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "MainViewController.h"
#import "ListCell.h"
#import <Foundation/NSFileManager.h>
#import "NewItemViewController.h"
#import "ViewItemViewController.h"

@implementation MainViewController
@synthesize tableview;

@synthesize itemList, selectedRow, dbname;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Going to: %@", [segue identifier]);
    
    if ([[segue identifier] isEqualToString:@"NewItem"]) {
        NewItemViewController *nictrl = segue.destinationViewController;
        nictrl.previous = self;
    }
    else if ([[segue identifier] isEqualToString:@"ViewItem"]) {
        ViewItemViewController *ctrl = segue.destinationViewController;
        NSMutableDictionary *dict = [self.itemList objectAtIndex:selectedRow.row];
        ctrl.key = [[dict allKeys] objectAtIndex:0];
        ctrl.value =[dict objectForKey:ctrl.key];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    [self setTableview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.itemList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemCell";
    ListCell *cell = (ListCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = [[[self.itemList objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath;
    return indexPath;
}

-(void)addObject:(NSMutableDictionary *)dict
{
    [self.itemList addObject:dict];
    BOOL rc = [self.itemList writeToFile:self.dbname atomically:NO];
    [self.tableview reloadData];
    NSLog(@"Writing to %@ %@", self.dbname, (rc ? @"OK" : @"FAILED"));
}
@end
