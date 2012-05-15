//
//  TLListListViewController.m
//  TaskLists
//
//  Created by Jimmy Theis on 5/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "TLListListViewController.h"
#import "TLAppDelegate.h"
#import "TLTaskList.h"
#import "TLTaskListViewController.h"

@interface TLListListViewController ()

@property (nonatomic, strong) NSArray *lists;

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)addList:(id)sender;

@end

@implementation TLListListViewController

@synthesize lists = _lists;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TLTaskList"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES]];
    
    self.lists = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    [self.tableView reloadData];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ListListToTaskListSegue"]) {
        TLTaskListViewController *taskList = segue.destinationViewController;
        taskList.list = [self.lists objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [(TLAppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - IBActions

- (void)addList:(id)sender
{
    TLTaskList *newList = [NSEntityDescription insertNewObjectForEntityForName:@"TLTaskList" inManagedObjectContext:self.managedObjectContext];
    
    newList.created = [NSDate date];
    newList.title = [NSString stringWithFormat:@"Task List %d", self.lists.count];
    
    [self.managedObjectContext save:nil];
    
    self.lists = [self.lists arrayByAddingObject:newList];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.lists.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TLTaskList *currentList = [self.lists objectAtIndex:indexPath.row];
    cell.textLabel.text = currentList.title;
    
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
        [self.managedObjectContext deleteObject:[self.lists objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TLTaskList"];
        fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES]];
        
        self.lists = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
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
