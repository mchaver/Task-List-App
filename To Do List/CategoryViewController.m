//
//  CategoryViewController.m
//  To Do List
//
//  Created by Jimmy Haver on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, strong) Database *database;
@property (nonatomic, strong) List *category;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@end

@implementation CategoryViewController
@synthesize categoryArray = _categoryArray;
@synthesize category = _category;
@synthesize database = _database;
@synthesize idArray = _idArray;

-(NSMutableArray *)idArray {
    if (!_idArray) _idArray = [[NSMutableArray alloc] init];
    return _idArray;
}

-(Database *)database {
    if(!_database) _database = [[Database alloc] init];
    return _database;
}

-(List *)category {
    if(!_category) _category = [[List alloc] init];
    return _category;
}



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
    self.title = NSLocalizedString(@"Lists", @"");
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
    return [self.categoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    List *categoryObj = [self.database.listArray objectAtIndex:indexPath.row];
    cell.textLabel.text = categoryObj.listName;
    [self.idArray addObject:categoryObj.listID];
    NSLog(@"From the array, %@",categoryObj.listID);
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.database selectAllLists];
    self.categoryArray = [self.database listArray];
    
    [self.tableView reloadData];
    self.idArray = [[NSMutableArray alloc] initWithObjects:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addList"]) {
        int categoryID = [self.database insertList];
        TaskViewController *viewController = [segue destinationViewController];
        viewController.category = [self.database selectList:categoryID];
        viewController.listID = categoryID;
    }
}

@end
