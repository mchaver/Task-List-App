//
//  ShowUnfinishedTaskCellViewController.m
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShowUnfinishedTaskCellViewController.h"

@interface ShowUnfinishedTaskCellViewController ()

@end

@implementation ShowUnfinishedTaskCellViewController
@synthesize taskName, notes, unfinishedTask;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    unfinishedTask = (UnfinishedTask *)[self unfinishedTask];
    self.taskName.text = unfinishedTask.taskName;
    self.notes.text = unfinishedTask.taskNotes;
}
@end
