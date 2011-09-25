//
//  Todo.h
//  Todo
//
//  Created by synactive on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface Todo : NSObject {
	
	sqlite3 *database;
	NSString *text;
	NSInteger primaryKey;
	NSInteger priority;
	BOOL status;
	BOOL dirty;

}

@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (nonatomic, retain) NSString *text;
@property (nonatomic) NSInteger priority;
@property (nonatomic) BOOL status;

- (id) initWithPrimaryKey:(NSInteger)pk database:(sqlite3*)db;
- (void) updateStatus:(NSInteger) newStatus;
- (void) updatePriority:(NSInteger) newPriority;
- (void) dehydrate;
- (void) deleteFromDatabase;
+ (NSInteger) insertNewTodoIntoDatabase:(sqlite3 *)database;

@end
