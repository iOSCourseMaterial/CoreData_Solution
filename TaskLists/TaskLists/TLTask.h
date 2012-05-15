//
//  TLTask.h
//  TaskLists
//
//  Created by Jimmy Theis on 5/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TLTaskList;

@interface TLTask : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) TLTaskList *list;

@end
