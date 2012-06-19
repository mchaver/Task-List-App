//
//  AddTaskViewController.h
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface AddTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *taskName;
@property (strong, nonatomic) IBOutlet UITextField *taskNotes;
@property (nonatomic, strong) Database *database;

-(IBAction)saveTaskToDatabase:(id)sender;
-(IBAction)backgroundTap:(id)sender;
//- (IBAction)saveToDo:(id)sender;
@end
