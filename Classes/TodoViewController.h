//
//  todoViewController.h
//  todo
//
//  Created by synactive on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"
#import "UICustomSwitch.h"

@interface TodoViewController : UIViewController {
	
	IBOutlet UITextField *todoText;
	IBOutlet UISegmentedControl *todoPriority;
	IBOutlet UICustomSwitch *todoStatusSwitch;
	IBOutlet UIDatePicker *datePicker;
	Todo *todo;

}

@property (nonatomic, retain) IBOutlet UITextField *todoText;
@property (nonatomic, retain) IBOutlet UISegmentedControl *todoPriority;
@property (nonatomic, retain) Todo *todo;
@property (nonatomic, retain) UICustomSwitch *todoStatusSwitch;
@property (nonatomic, retain) UIDatePicker *datePicker;

- (IBAction) updateStatus:(id)sender;
- (IBAction) updatePriority:(id)sender;
- (IBAction) updateText:(id)sender;
- (IBAction) updateDueDate:(id) sender;

- (void) setTodoDisplay;

@end
