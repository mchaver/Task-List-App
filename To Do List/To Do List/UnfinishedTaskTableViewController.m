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
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Unfinished Tasks", @"");
 
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


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
    Task *unfinishedTaskObj = [database.taskArray objectAtIndex:indexPath.row];
    cell.textLabel.text = unfinishedTaskObj.taskName;
    [idArray addObject:unfinishedTaskObj.taskID];
    NSLog(@"From the array, %@",unfinishedTaskObj.taskID);
    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    taskArray = [[NSMutableArray alloc] init];
    database = [[Database alloc] init];
    [database selectAllUnfinishedTasks];
    taskArray = [database taskArray];
    [self.tableView reloadData];
    idArray = [[NSMutableArray alloc] initWithObjects:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showUnfinishedTaskCell"]) {
        ShowUnfinishedTaskCellViewController *viewController = [segue destinationViewController];
        viewController.unfinishedTask = [self.taskArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

//deleting a row
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        //switch to a db call
        int idValue = [[idArray objectAtIndex:indexPath.row] intValue];
        if([database deleteTask:idValue]) {
            [taskArray removeObjectAtIndex:indexPath.row];
            [idArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            NSLog(@"There was trouble deleting the cell row");
        }
    }
}

@end
