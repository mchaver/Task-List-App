//
//  AppDelegate.m
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Database.h"

@interface AppDelegate()
@property (nonatomic, strong) Database *database;
@end
@implementation AppDelegate

@synthesize window = _window;
@synthesize database = _database;

-(Database *)database {
    if(!_database) _database = [[Database alloc] init];
    return _database;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.database createListAndTaskTables];
    /*
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
            const char *sqlTable1 = "CREATE TABLE if not exists category (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, category TEXT NOT NULL)";
            if(sqlite3_exec(db,sqlTable1, NULL, NULL, &emsg) != SQLITE_OK){
                NSLog(@"Creating the table did not work");
            } else {
                NSLog(@"The table has been created");
            }
            
            const char *sqlTable2 = "CREATE TABLE if not exists todo (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , task TEXT NOT NULL , notes TEXT, datetime DOUBLE, finished BOOL NOT NULL DEFAULT FALSE, categoryid INTEGER NOT NULL, FOREIGN KEY(categoryid) REFERENCES category(id))";
            
            if(sqlite3_exec(db,sqlTable2, NULL, NULL, &emsg) != SQLITE_OK){
                NSLog(@"Creating the table did not work");
            } else {
                NSLog(@"The table has been created");
            }
            sqlite3_close(db);
        }
    }
    */
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
