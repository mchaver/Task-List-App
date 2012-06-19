//
//  Database.m
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Database.h"

@interface Database()
@property (nonatomic, strong) Task *task;
@property (nonatomic, strong) List *category;
@end

@implementation Database

@synthesize listArray = _listArray;
@synthesize taskArray = _taskArray;
@synthesize task = _task;
@synthesize category = _category;

-(NSMutableArray *)taskArray {
    if (!_taskArray) _taskArray = [[NSMutableArray alloc] init];
    return _taskArray;
}

-(NSMutableArray *)listArray {
    if (!_listArray) _listArray = [[NSMutableArray alloc] init];
    return _listArray;
}

-(void) createListAndTaskTables{
    char *emsg;
    BOOL fileExist;
    
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    
    //delete database file
    [[NSFileManager defaultManager] removeItemAtPath:documentPath error:nil];
    fileExist = [[NSFileManager alloc] fileExistsAtPath:documentPath];
    if(!fileExist) {
        if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
            
        } else {
            const char *sqlTable1 = "CREATE TABLE if not exists list (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, list TEXT NOT NULL)";
            if(sqlite3_exec(db,sqlTable1, NULL, NULL, &emsg) != SQLITE_OK){
                NSLog(@"Creating the table did not work");
            } else {
                NSLog(@"The table has been created");
            }
            
            const char *sqlTable2 = "CREATE TABLE if not exists todo (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , task TEXT NOT NULL , notes TEXT, datetime DOUBLE, finished BOOL NOT NULL DEFAULT FALSE, listid INTEGER NOT NULL, FOREIGN KEY(listid) REFERENCES list(id))";
            
            if(sqlite3_exec(db,sqlTable2, NULL, NULL, &emsg) != SQLITE_OK){
                NSLog(@"Creating the table did not work");
            } else {
                NSLog(@"The table has been created");
            }
            sqlite3_close(db);
        }
    }
}

-(void) selectAllUnfinishedTasks{
    self.taskArray = [[NSMutableArray alloc] init];
    
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    
    if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
        NSLog(@"An error has occured.");
        return;
    } else {
        const char *sql = "select id,task,notes, datetime from todo where finished == 'false'";
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"There is a problem with prepare statement");
            return;
        } else {
            while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
                char *checkChar = (char *)sqlite3_column_text(sqlStatement, 1);
                if(checkChar!=NULL) {
                    Task *newUnfinishedTask = [[Task alloc] init];
                    newUnfinishedTask.taskID = [NSNumber numberWithInt:sqlite3_column_int(sqlStatement, 0)];
                    newUnfinishedTask.taskName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStatement, 1)];
                    newUnfinishedTask.taskNotes = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStatement,2)];
                    newUnfinishedTask.taskDate = [NSDate dateWithTimeIntervalSince1970:sqlite3_column_double(sqlStatement, 3)];
                    
                    [self.taskArray addObject:newUnfinishedTask];
                    newUnfinishedTask = nil;
                }
            }
            sqlite3_finalize(sqlStatement);
            sqlite3_close(db);
        }
    }
}

-(void) selectAllLists{
    self.listArray = [[NSMutableArray alloc] init];
    
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    
    if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
        NSLog(@"An error has occured.");
        return;
    } else {
        const char *sql = "select id,list from list";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"There is a problem with prepare statement");
            return;
        } else {
            while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
                char *checkChar = (char *)sqlite3_column_text(sqlStatement, 1);
                if(checkChar!=NULL) {
                    List *newCategory = [[List alloc] init];
                    newCategory.listID = [NSNumber numberWithInt:sqlite3_column_int(sqlStatement, 0)];
                    newCategory.listName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStatement, 1)];
                
                    [self.listArray addObject:newCategory];
                    newCategory = nil;
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
        NSDate *dateToWrite = [NSDate date];
        double dateToSQL = [dateToWrite timeIntervalSince1970];
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO todo(task, notes, datetime, finished) VALUES ('%@', '%@', '%@', 'false')", taskName, taskNotes,[NSNumber numberWithDouble:dateToSQL]];
        const char *sql = [insertSQL UTF8String];
        sqlite3_stmt *sqlStatement;
        if (sqlite3_prepare_v2(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"Problem with prepare statement");
            return;
        } else {
            
            if(sqlite3_step(sqlStatement)==SQLITE_DONE) {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(db);
            } else {
                NSLog(@"There was an error writing the task to the database");
            }
        }
    }
}

-(BOOL) deleteTask:(int)taskId{
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    BOOL result;
    
    if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
        NSLog(@"An error has occured.");
        result = NO;
    } else {
        const char *sql = "delete from todo where ID = ?";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(db));
        }
        
        sqlite3_bind_int(sqlStatement, 1, taskId);
        
        if (SQLITE_DONE != sqlite3_step(sqlStatement)){ 
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(db));
        }
        sqlite3_reset(sqlStatement);
        sqlite3_close(db);
        result = YES;
    }
    return result;
}

-(int) insertList{
    //returns -1 if it did not work right
    //create a new category with name 'holdingvalue'
    //get the id value and rename it to List#id
    //if succeeds return id value
    
    int newCategoryID = -1;
    
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    
    if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
        NSLog(@"An error has occured");
    } else {
        char* errmsg;
       
        const char *sql = "INSERT INTO list(list) VALUES('holdingvalue')";
        sqlite3_stmt *sqlStatement;
        if (sqlite3_prepare_v2(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"Problem with prepare statement");
        } else {
            sqlite3_exec(db, "BEGIN TRANSACTION", NULL, NULL, &errmsg);
            
            if(sqlite3_step(sqlStatement)==SQLITE_DONE) {
                sqlite3_finalize(sqlStatement);
                
                newCategoryID = sqlite3_last_insert_rowid(db);
                NSString *newCategoryName = [NSString stringWithFormat:@"List #%i", newCategoryID];
                NSString *insertSQL = [NSString stringWithFormat:@"UPDATE list SET list = '%@' WHERE id = '%i'", newCategoryName, newCategoryID];
                const char *sql = [insertSQL UTF8String];
                
                if(sqlite3_prepare_v2(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
                    NSLog(@"Problem with prepare statement");
                } else {
                    if(sqlite3_step(sqlStatement)==SQLITE_DONE) {
                        sqlite3_finalize(sqlStatement);
                        sqlite3_exec(db, "COMMIT", NULL, NULL, &errmsg);
                        sqlite3_close(db);
                    } else {
                        NSLog(@"There was a problem updating the name");
                    }
                }
            } else {
                NSLog(@"There was an error writing the category to the database");
            }
        }
    }
    return newCategoryID;
}

-(List *) selectList:(int)listID{
    List *returnCategory = [[List alloc] init];
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    
    if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
        NSLog(@"An error has occured");
    } else {
        //char* errmsg;
        NSString *insertSQL = [NSString stringWithFormat:@"SELECT id,list FROM list where id == '%i'", listID];
        const char *sql = [insertSQL UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare_v2(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"Problem with prepare statement");
        } else {
            while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
                char *checkChar = (char *)sqlite3_column_text(sqlStatement, 1);
                if(checkChar!=NULL) {
                    returnCategory.listID = [NSNumber numberWithInt:sqlite3_column_int(sqlStatement, 0)];
                    returnCategory.listName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStatement, 1)];
                }
            }
            sqlite3_finalize(sqlStatement);
            sqlite3_close(db);
        }
        
    }
    NSLog(@"%@", returnCategory.listName);
    return returnCategory;
}

-(void)insertTask:(NSString *)taskName withListID:(int)listID {
    
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
        NSLog(@"An error has occured");
    } else {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO todo(task, listid, finished) VALUES ('%@', '%@', 'false')", taskName, listID];
        const char *sql = [insertSQL UTF8String];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare_v2(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK) {
            NSLog(@"Problem with prepare statement");
        } else {
            if(sqlite3_step(sqlStatement)==SQLITE_DONE) {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(db);
            } else {
                NSLog(@"There was an error writing the task to the database");
            }
        }
    }
}

@end
