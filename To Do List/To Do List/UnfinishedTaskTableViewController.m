//
//  UnfinishedTaskTableViewController.m
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UnfinishedTaskTableViewController.h"

@interface UnfinishedTaskTableViewController ()

@end

@implementation UnfinishedTaskTableViewController
@synthesize database, unfinishedTask, taskArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Unfinished Tasks", @"");
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    NSLog(@"Goodbye");
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [taskArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"unfinishedTaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UnfinishedTask *unfinishedTaskObj = [database.taskArray objectAtIndex:indexPath.row];
    cell.textLabel.text = unfinishedTaskObj.taskName;
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    taskArray = [[NSMutableArray alloc] init];
    database = [[Database alloc] init];
    [database selectAllUnfinishedTasks];
    taskArray = [database taskArray];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showUnfinishedTaskCell"]) {
        ShowUnfinishedTaskCellViewController *viewController = [segue destinationViewController];
        viewController.unfinishedTask = [self.taskArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        //todoViewController *viewController = [segue destinationViewController];
        //viewController.todoDetail = [self.todoArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
