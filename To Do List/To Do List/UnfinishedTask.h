//
//  UnfinishedTask.h
//  To Do List
//
//  Created by Jimmy Haver on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnfinishedTask : NSObject

@property(nonatomic, strong) NSString *taskName;
@property(nonatomic, strong) NSString *taskNotes;
@property(nonatomic, strong) NSDate *taskDate;

@end
