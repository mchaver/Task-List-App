//
//  UnfinishedTaskTableViewController.h
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "UnfinishedTask.h"
#import "ShowUnfinishedTaskCellViewController.h"

@interface UnfinishedTaskTableViewController : UITableViewController

@property(nonatomic, strong) UnfinishedTask *unfinishedTask;
@property(nonatomic, strong) Database *database;
@property(nonatomic, strong) NSMutableArray *taskArray;

@end
