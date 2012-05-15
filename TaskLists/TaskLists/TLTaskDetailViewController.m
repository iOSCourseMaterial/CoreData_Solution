//
//  TLTaskDetailViewController.m
//  TaskLists
//
//  Created by Jimmy Theis on 5/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "TLTaskDetailViewController.h"
#import "TLAppDelegate.h"
#import "TLTask.h"

@interface TLTaskDetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField *detailsField;

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)save:(id)sender;

@end

@implementation TLTaskDetailViewController

@synthesize detailsField = _detailsField;
@synthesize task  = _task;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.detailsField.text = self.task.details;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [(TLAppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - IBActions

- (void)save:(id)sender
{
    self.task.details = self.detailsField.text;
    
    [self.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
