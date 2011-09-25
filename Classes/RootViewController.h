//
//  RootViewController.h
//  todo
//
//  Created by synactive on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoViewController.h"

@interface RootViewController : UITableViewController {
	TodoViewController *todoView;
}

@property (nonatomic, retain) TodoViewController *todoView;

@end
