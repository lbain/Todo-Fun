//
//  RootViewController.m
//  todo
//
//  Created by synactive on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "todoAppDelegate.h"
#import "TodoCell.h"
#import "Todo.h"

@implementation RootViewController

@synthesize todoView;

- (void)viewDidLoad {
    //[super viewDidLoad];
	
	self.title = @"Things To Do";
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem * btn = [[UIBarButtonItem alloc] initWithTitle:@"Add" 
															 style:UIBarButtonItemStyleBordered 
															target:self 
															action:@selector(addTodo:)];
	
	self.navigationItem.rightBarButtonItem = btn;
}

- (void) addTodo:(id) sender {
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (self.todoView == nil) {
		TodoViewController *viewController = [[TodoViewController alloc]
											 initWithNibName:@"TodoViewController" bundle:[NSBundle mainBundle]];
		self.todoView = viewController;
		[viewController release];
	}
	
	Todo *todo = [appDelegate addTodo];
	[self.navigationController pushViewController:self.todoView animated:YES];
	self.todoView.todo = todo;
	[todoView setTodoDisplay];
}

- (void) tableView: (UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingSytle
											   forRowAtIndexPath:(NSIndexPath *)indexPath {
	todoAppDelegate *appDelegate = (todoAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	Todo *todo = (Todo *)[appDelegate.todos objectAtIndex:indexPath.row];
	
	if (editingSytle == UITableViewCellEditingStyleDelete) {
		[appDelegate removeTodo:todo];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	todoAppDelegate *appDelegate = (todoAppDelegate *) [[UIApplication sharedApplication] delegate];
	return appDelegate.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
    TodoCell *cell = (TodoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[TodoCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	todoAppDelegate *appDelegate = (todoAppDelegate *) [[UIApplication sharedApplication] delegate];
	Todo *td = [appDelegate.todos objectAtIndex:indexPath.row];
	
	[cell setTodo:td];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
	Todo *todo = (Todo *)[appDelegate.todos objectAtIndex:indexPath.row];
	
	if(self.todoView == nil) {
		TodoViewController *viewController = [[TodoViewController alloc] 
											  initWithNibName:@"TodoViewController" bundle:[NSBundle mainBundle]];
		self.todoView = viewController;
		[viewController release];
	}
	
	[self.navigationController pushViewController:self.todoView animated:YES];
	self.todoView.todo = todo;
	[todoView setTodoDisplay];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];// Releases the view if it doesn't have a superview.
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end

