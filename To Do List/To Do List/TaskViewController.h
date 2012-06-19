//
//  TaskViewController.h
//  To Do List
//
//  Created by Jimmy Haver on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface TaskViewController : UITableViewController <UITextFieldDelegate> {
    sqlite3 *db;
    NSMutableArray *idArray;
    //int listID;
}

@property (readwrite) NSInteger listID;
@property (nonatomic, strong) Task *task;
@property (nonatomic, strong) List *category;
@property(nonatomic, strong) NSMutableArray *taskArray;
@property(nonatomic, strong) Database *database;
@property(nonatomic, strong) NSMutableArray *cellArray;
-(IBAction)addNewTask:(id)sender;

@end
