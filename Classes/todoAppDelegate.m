//
//  todoAppDelegate.m
//  todo
//
//  Created by synactive on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "todoAppDelegate.h"
#import "RootViewController.h"
#import "todo.h"

@interface todoAppDelegate (Private)

-(void) createEditableCopyOfDatabaseIfNeeded;
-(void) initializeDatabase;

@end


@implementation todoAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize todos;

- (id)init {
	if (self = [super init]) {
		// 
	}
	return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	[self createEditableCopyOfDatabaseIfNeeded];
	[self initializeDatabase];
	
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	
    return YES;
}

-(void) createEditableCopyOfDatabaseIfNeeded {
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writeableDBPath = [documentsDirectory stringByAppendingPathComponent:@"todo1.sqlite"];
	success = [fileManager fileExistsAtPath:writeableDBPath];
	
	if(success) return;
	
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"todo1.sqlite"];
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writeableDBPath error:&error];
	if (!success) {
		NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

-(void) initializeDatabase {
	NSMutableArray *todoArray = [[NSMutableArray alloc] init];
	self.todos = todoArray;
	[todoArray release];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"todo1.sqlite"];
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
		const char *sql = "SELECT pk FROM todo";
		sqlite3_stmt *statement;
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
			while (sqlite3_step(statement) == SQLITE_ROW) {
				int primaryKey = sqlite3_column_int(statement, 0);
				Todo *td= [[Todo alloc] initWithPrimaryKey:primaryKey database:database];
				[todos addObject:td];
				[td release];
			}
		}
		sqlite3_finalize(statement);
	} else {
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
}

- (Todo *) addTodo {
	NSInteger primaryKey = [Todo insertNewTodoIntoDatabase:database];
	Todo *newTodo = [[Todo alloc] initWithPrimaryKey:primaryKey database:database];
	
	[todos addObject:newTodo];
	return newTodo;	
}

- (void) removeTodo:(Todo *)todo {
	NSUInteger index = [todos indexOfObject:todo];
	
	if (index == NSNotFound) return;
	
	[todo deleteFromDatabase];
	[todos removeObject:todo];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	
	[todos makeObjectsPerformSelector:@selector(dehydrate)];
}

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}





#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}





@end

