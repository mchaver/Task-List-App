//
//  Database.m
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Database.h"

@implementation Database
@synthesize taskArray;

-(void) selectAllUnfinishedTasks{
    taskArray = [[NSMutableArray alloc] init];
    
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    
    if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
        NSLog(@"An error has occured.");
        return;
    } else {
        //const char *sql = "select task, notes from todo where finished = false";
        const char *sql = "select task, notes from todo";
        sqlite3_stmt *sqlStatement;
        
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"There is a problem with prepare statement");
            return;
        } else {
            while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
                char *checkChar = (char *)sqlite3_column_text(sqlStatement, 1);
                if(checkChar!=NULL) {
                    UnfinishedTask *newUnfinishedTask = [[UnfinishedTask alloc] init];
                    
                    newUnfinishedTask.taskName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStatement, 0)];
                    newUnfinishedTask.taskNotes = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStatement,1)];
                    //double doubleDate = sqlite3_column_double(sqlStatement,2);
                    //newUnfinishedTask.taskDate = [NSDate dateWithTimeIntervalSince1970:doubleDate];
                    
                    [taskArray addObject:newUnfinishedTask];
                    newUnfinishedTask = nil;
                }
            }
            sqlite3_finalize(sqlStatement);
            sqlite3_close(db);
        }
    }
}


-(void) insertTask:(NSString *)taskName taskNotes:(NSString *)taskNotes {
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    
    if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
        NSLog(@"An error has occured");
        return;
    } else {
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO todo(task, notes) VALUES ('%@', '%@')", taskName, taskNotes];
        const char *sql = [insertSQL UTF8String];
        sqlite3_stmt *sqlStatement;
        if (sqlite3_prepare_v2(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"Problem with prepare statement");
            return;
        } else {
            
            if(sqlite3_step(sqlStatement)==SQLITE_DONE) {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(db);
            }
        }
    }
}



@end
