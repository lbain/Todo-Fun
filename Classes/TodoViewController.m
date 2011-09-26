//
//  TodoViewConroller.m
//  todo
//
//  Created by synactive on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TodoViewController.h"


@implementation TodoViewController

@synthesize todoText, todoPriority, todoStatusSwitch, datePicker, todo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
		// Custom YES/NO
		self.todoStatusSwitch = [[UICustomSwitch alloc] initWithFrame:CGRectZero];
		self.todoStatusSwitch = [UICustomSwitch switchWithLeftText:@"Done" andRight:@"To Do"];
		CGSize newSize;
		newSize.width = 1.4;
		newSize.height = 1.4;
		[self.todoStatusSwitch scaleSwitch:newSize]; //Uses |newSize| as percentages for the new image
		self.todoStatusSwitch.center = CGPointMake(160.0f, 75.0f);
		self.todoStatusSwitch.on = YES;
	//	[self.todoStatusSwitch addTarget:self action:@selector(updateStatus:) forControlEvents:UIControlEventValueChanged];
		[self.view addSubview:self.todoStatusSwitch];

	}
	return self;
}

- (IBAction) updateStatus:(id)sender {
	[self.todo updateStatus:!todo.status];
}

- (void) setTodoDisplay {
	
	self.title = todo.text;
	[self.todoText setText:todo.text];
	[self.datePicker setDate:todo.dueDate animated:YES];
	
	[self.todoPriority setSelectedSegmentIndex:todo.priority-1];
}

- (IBAction) updatePriority:(id)sender {
	int priority = [self.todoPriority selectedSegmentIndex];
	[self.todo updatePriority:(priority+1)];
}

- (IBAction) updateText:(id) sender {
	self.todo.text = self.todoText.text;
}

- (IBAction) updateDueDate:(id) sender {
	//get date
	NSDate *selectedDate = [[datePicker date] retain];
	//update todo object's date
	[todo updateDueDate:selectedDate];
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
