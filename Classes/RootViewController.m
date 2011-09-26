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

@synthesize todoView, toolbar, appDelegate;

- (void)viewDidLoad {
    //[super viewDidLoad];
	
	self.title = @"Things To Do";
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem * addItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" 
															 style:UIBarButtonItemStyleBordered 
															target:self 
															action:@selector(addTodo:)];
	UIBarButtonItem * sortElements = [[UIBarButtonItem alloc] initWithTitle:@"Sort" 
															 style:UIBarButtonItemStyleBordered 
															target:self 
															action:@selector(sortDisplay)];
	self.navigationItem.rightBarButtonItem = addItem;
	
	
	toolbar = [[UIToolbar alloc] init];
	toolbar.barStyle = UIBarStyleDefault;
	
	[toolbar sizeToFit];
	CGFloat toolbarHeight = [toolbar frame].size.height;
	CGRect viewBounds = self.parentViewController.view.bounds;
	CGFloat rootViewHeight = CGRectGetHeight(viewBounds);
	CGFloat rootViewWidth = CGRectGetWidth(viewBounds);
	CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
	
	[toolbar setFrame:rectArea];
	
	[self.navigationController.view addSubview:toolbar];
	
	NSMutableArray *footerButtons = [[NSMutableArray alloc] init];
	[footerButtons addObject:sortElements];
	
	[toolbar setItems:footerButtons];
	
	appDelegate = (todoAppDelegate *)[[[UIApplication sharedApplication] delegate]retain];
	
}

- (void) addTodo:(id) sender {
	
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

- (void) sortDisplay {
	[appDelegate sortByDueDate];
	[[self tableView] reloadData];
}

- (void) tableView: (UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingSytle
											   forRowAtIndexPath:(NSIndexPath *)indexPath {
	
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
	return appDelegate.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
    TodoCell *cell = (TodoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[TodoCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	Todo *td = [appDelegate.todos objectAtIndex:indexPath.row];
	
	[cell setTodo:td];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
	[appDelegate release];
    [super dealloc];
}

@end

