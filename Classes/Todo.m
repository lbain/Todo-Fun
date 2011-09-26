//
//  Todo.m
//  Todo
//
//  Created by synactive on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Todo.h"

static sqlite3_stmt *init_statement = nil;
static sqlite3_stmt *dehydrate_statement = nil;
static sqlite3_stmt *delete_statement = nil;
static sqlite3_stmt *insert_statement = nil;

@implementation Todo

@synthesize primaryKey, text, dueDate, priority, status;

-(id) initWithPrimaryKey:(NSInteger)pk database:(sqlite3*)db
{
	if (self = [super init]) {
		primaryKey = pk;
		database = db;
		
		if (init_statement == nil) {
			const char *sql = "SELECT text,priority,complete,dueDate FROM todo WHERE pk=?";
			
			if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with message'%s'.", sqlite3_errmsg(database));
			}
		}
	}
	
	sqlite3_bind_int(init_statement, 1, primaryKey);
	if (sqlite3_step(init_statement) == SQLITE_ROW) {
		self.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
		self.priority = sqlite3_column_int(init_statement,1);
		self.status = sqlite3_column_int(init_statement, 2);
		[self setDueDate:[NSDate dateWithTimeIntervalSince1970:(int)sqlite3_column_int(init_statement, 3)]];
	}
	
	sqlite3_reset(init_statement);
	
	return self;
}

+ (NSInteger) insertNewTodoIntoDatabase:(sqlite3 *)database {
	if (insert_statement == nil) {
		static char*sql = "INSERT INTO todo (text,priority,complete) VALUES('New Todo', 1, 0)";
		if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	int success = sqlite3_step(insert_statement);
	
	sqlite3_reset(insert_statement);
	if (success != SQLITE_ERROR) {
		return sqlite3_last_insert_rowid(database);
	}
	NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
	return -1;
}

- (void) updateStatus:(NSInteger)newStatus{
	self.status = newStatus;
	dirty = YES;
}

- (void) updatePriority:(NSInteger)newPriority {
	self.priority = newPriority;
	dirty = YES;
}

- (void) updateDueDate:(NSDate *)newDate {
	[self setDueDate:newDate];
	dirty = YES;
}

- (void) printDueDate {
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
	NSString *printDate = [dateFormat stringFromDate:[self dueDate]];
	NSLog(@"The date is: %@", printDate);
	[dateFormat release];
}

- (Todo *) todo
{
	return self.todo;
}

- (void) deleteFromDatabase {
	if (delete_statement == nil) {
		const char *sql = "DELETE FROM todo WHERE pk=?";
		if (sqlite3_prepare_v2(database, sql, -1, &delete_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	
	sqlite3_bind_int(delete_statement, 1, self.primaryKey);
	int success = sqlite3_step(delete_statement);
	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to delete todo from database with message '%s'.", sqlite3_errmsg(database));
	}
	
	sqlite3_reset(delete_statement);
}

- (void) dehydrate {
	if (dirty) {
		if (dehydrate_statement == nil) {
			const char *sql = "UPDATE todo SET text = ?, priority = ?, complete = ?, dueDate = ?, WHERE pk = ?";
			if (sqlite3_prepare_v2(database, sql, -2, &dehydrate_statement, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with mesage '%s'.", sqlite3_errmsg(database));
			}
		}
	
		sqlite3_bind_int(dehydrate_statement, 5, self.primaryKey);
		sqlite3_bind_int(dehydrate_statement, 4, [self.dueDate timeIntervalSince1970]);
		sqlite3_bind_int(dehydrate_statement, 3, self.status);
		sqlite3_bind_int(dehydrate_statement, 2, self.priority);
		sqlite3_bind_int(dehydrate_statement, 1, *[self.text UTF8String]);
		
		int success = sqlite3_step(dehydrate_statement);
		
		if (success != SQLITE_DONE) {
			NSAssert1(0, @"Error: failed to save priority with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_reset(dehydrate_statement);
		dirty = NO;
	}
}


@end
