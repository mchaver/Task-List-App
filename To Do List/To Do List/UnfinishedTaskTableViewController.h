//
//  UnfinishedTaskTableViewController.h
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "Task.h"
#import "ShowUnfinishedTaskCellViewController.h"

@interface UnfinishedTaskTableViewController : UITableViewController {
    NSMutableArray *idArray;
}

@property(nonatomic, strong) Task *unfinishedTask;
@property(nonatomic, strong) Database *database;
@property(nonatomic, strong) NSMutableArray *taskArray;

@end
