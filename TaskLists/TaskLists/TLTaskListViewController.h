//
//  TLTaskListViewController.h
//  TaskLists
//
//  Created by Jimmy Theis on 5/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLTaskList;

@interface TLTaskListViewController : UITableViewController

@property (nonatomic, strong) TLTaskList *list;

@end
