//
//  TLTaskListViewController.m
//  TaskLists
//
//  Created by Jimmy Theis on 5/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "TLTaskListViewController.h"
#import "TLAppDelegate.h"
#import "TLTaskDetailViewController.h"
#import "TLTaskList+Customization.h"
#import "TLTask.h"

@interface TLTaskListViewController ()

- (IBAction)addTask:(id)sender;

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation TLTaskListViewController

@synthesize list = _list;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TaskListToTaskDetailSegue"]) {
        TLTaskDetailViewController *taskDetail = segue.destinationViewController;
        taskDetail.task = [self.list.sortedTasks objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [(TLAppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - IBActions

- (void)addTask:(id)sender
{
    TLTask *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"TLTask" inManagedObjectContext:self.managedObjectContext];
    
    newTask.details = [NSString stringWithFormat:@"New Task %d", self.list.tasks.count];
    newTask.created = [NSDate date];
    newTask.list = self.list;
    
    [self.managedObjectContext save:nil];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.list.tasks.count - 1 inSection:0]; 
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]  withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TLTask *currentTask = [self.list.sortedTasks objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentTask.details;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.managedObjectContext deleteObject:[self.list.sortedTasks objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
