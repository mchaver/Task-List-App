//
//  AppDelegate.m
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    char *emsg;
    BOOL fileExist;
    
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"todo.sqlite"];
    
    fileExist = [[NSFileManager alloc] fileExistsAtPath:documentPath];
    //delete database file
    //[[NSFileManager defaultManager] removeItemAtPath:documentPath error:nil];
    if(!fileExist) {
        if(!(sqlite3_open([documentPath UTF8String], &db) == SQLITE_OK)) {
            
        } else {
            const char *sqlTable = "CREATE TABLE if not exists todo (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , task TEXT NOT NULL , notes TEXT, datetime DATETIME, finished BOOL NOT NULL DEFAULT FALSE)";
            
            if(sqlite3_exec(db,sqlTable, NULL, NULL, &emsg) != SQLITE_OK){
                NSLog(@"There is a problem with the SQL statement");
            }
            
        }
    }
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
