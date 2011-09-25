//
//  TodoViewConroller.m
//  todo
//
//  Created by synactive on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TodoViewController.h"


@implementation TodoViewController

@synthesize todoText, todoPriority, todoStatus, todoButton, todo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (IBAction) updateStatus:(id)sender {
	//if todo is complete
	if(todo.status == 0) {
		[self.todo updateStatus:1];
	} else {
		[self.todo updateStatus:0];
	}
	
	[self setStatusDisplay];
}

- (void) setTodoDisplay {
	
	self.title = todo.text;
	[self.todoText setText:todo.text];
	
	[self.todoPriority setSelectedSegmentIndex:todo.priority-1];
	[self setStatusDisplay];
}

- (IBAction) updatePriority:(id)sender {
	int priority = [self.todoPriority selectedSegmentIndex];
	[self.todo updatePriority:(priority+1)];
}

- (IBAction) updateText:(id) sender {
	self.todo.text = self.todoText.text;
}

- (void) setStatusDisplay {
	if(todo.status == 0) {
		[todoButton setTitle:@"Mark As In Progress" forState:UIControlStateNormal];
		[todoButton setTitle:@"Mark As In Progress" forState:UIControlStateHighlighted];
		[todoStatus setText:@"Complete"];
		//if todo is in progress
	} else {
		[todoButton setTitle:@"Mark As Complete" forState:UIControlStateNormal];
		[todoButton setTitle:@"Mark As Complete" forState:UIControlStateHighlighted];
		[todoStatus setText:@"In Progress"];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];// Releases the view if it doesn't have a superview.
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}


@end
