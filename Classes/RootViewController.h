//
//  RootViewController.h
//  todo
//
//  Created by synactive on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoViewController.h"
#import "todoAppDelegate.h"

@interface RootViewController : UITableViewController {
	TodoViewController *todoView;
	UIToolbar *toolbar;
	todoAppDelegate *appDelegate;
}

@property (nonatomic, retain) TodoViewController *todoView;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) todoAppDelegate *appDelegate;

@end
