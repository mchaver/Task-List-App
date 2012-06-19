//
//  ShowUnfinishedTaskCellViewController.h
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface ShowUnfinishedTaskCellViewController : UIViewController

@property (nonatomic, strong) Task * unfinishedTask;
@property (strong, nonatomic) IBOutlet UILabel *taskName;
@property (strong, nonatomic) IBOutlet UILabel *notes;
@property (strong, nonatomic) IBOutlet UILabel *date;
@end
