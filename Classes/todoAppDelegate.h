//
//  todoAppDelegate.h
//  todo
//
//  Created by synactive on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class Todo;

@interface todoAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	sqlite3 *database;
	NSMutableArray *todos;
	NSString *pathComponent;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *todos;
@property (nonatomic, retain) NSString *pathComponent;

- (Todo *) addTodo;
- (void) removeTodo:(Todo *)todo;
- (void) sortByDueDate;

@end

