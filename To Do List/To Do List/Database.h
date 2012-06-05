//
//  Database.h
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "UnfinishedTask.h"

@interface Database : NSObject{
    sqlite3 *db;
    UnfinishedTask *unfinishedTask;
}

@property(strong, atomic) NSMutableArray *taskArray;
-(void) selectAllUnfinishedTasks;
-(void) insertTask:(NSString *)taskName taskNotes:(NSString *)taskNotes;

//-(void) selectAllFinishedTasks;

@end
