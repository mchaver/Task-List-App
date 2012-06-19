//
//  TaskViewController.m
//  To Do List
//
//  Created by Jimmy Haver on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()

@end

@implementation TaskViewController
@synthesize task, category, database, taskArray, cellArray;
@synthesize listID = _listID;

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
    return [cellArray count];

    //return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        //for the List name
        if ([indexPath section] == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            UITextField *categoryTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
            categoryTextField.adjustsFontSizeToFitWidth = YES;
            categoryTextField.textColor = [UIColor blackColor];
            categoryTextField.delegate = self;
            categoryTextField.tag = indexPath.row;
            
            if ([indexPath row] == 0) {
                //for new list
                categoryTextField.placeholder = category.listName;
            } else {
                //for new task
                Task *newTask = [cellArray objectAtIndex:indexPath.row];
                categoryTextField.placeholder = newTask.taskName;
            }
            [cell.contentView addSubview:categoryTextField];
            
        } 
    }
    return cell;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    category = (List *)[self category];
    cellArray = [[NSMutableArray alloc] init];
    [cellArray addObject:category];
    [self.tableView reloadData];
    //start keyboard at first cell
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(void) textFieldDidEndEditing: (UITextField * ) textField {
    //if leave add placeholder name
    textField.text = textField.placeholder;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"The return button has been pressed:%@", textField.text);
    NSLog(@"tag value is %i", textField.tag);
    if(textField.tag > 0 && textField.text) {
        [database insertTask:textField.text withListID:self.listID];
        NSLog(@"Has been inserted");
    }
    return false;
}

-(void)addNewTask:(id)sender {
    task = [[Task alloc] init];
    task.taskName = @"TaskCellTest";
    [cellArray addObject:task];
    NSLog(@"Hello I am in the IBAction");
    [self.tableView reloadData];
}

@end
