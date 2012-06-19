//
//  Database.h
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Task.h"
#import "List.h"

@interface Database : NSObject{
    sqlite3 *db;
}

@property(nonatomic, strong) NSMutableArray *taskArray;
@property(nonatomic, strong) NSMutableArray *listArray;

-(void) createListAndTaskTables;

-(void) selectAllUnfinishedTasks;
-(void) selectAllLists;
-(List *) selectList:(int)listID;

-(void) insertTask:(NSString *)taskName taskNotes:(NSString *)taskNotes;
-(void) insertTask:(NSString *)taskName withListID:(int)listID;
-(int) insertList;

-(void) updateList;
-(void) updateTask;

-(BOOL) deleteTask:(int)taskId;

@end
