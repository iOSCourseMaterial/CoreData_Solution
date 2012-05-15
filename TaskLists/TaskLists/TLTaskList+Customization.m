//
//  TLTaskList+Customization.m
//  TaskLists
//
//  Created by Jimmy Theis on 5/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "TLTaskList+Customization.h"
#import "TLTask.h"

@implementation TLTaskList (Customization)

- (NSArray *)sortedTasks
{
    return [self.tasks.allObjects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(TLTask *) obj1 created] compare:[(TLTask *) obj2 created]];
    }];
}

@end
