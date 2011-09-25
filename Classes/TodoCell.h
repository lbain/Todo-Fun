//
//  TodoCell.h
//  todo
//
//  Created by synactive on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface TodoCell : UITableViewCell {
	Todo *todo;
	UILabel *todoTextLabel;
	UILabel *todoPriorityLabel;
	UILabel *todoStatusLabel;
	UIImageView *todoPriorityImageView;
}

@property (nonatomic,retain) UILabel *todoTextLabel;
@property (nonatomic, retain) UILabel *todoPriorityLabel;
@property (nonatomic, retain) UILabel *todoStatusLabel;
@property (nonatomic, retain) UIImageView *todoPriorityImageView;

- (UIImage *) imageForPriority:(NSInteger) priority;

- (Todo *)todo;
- (void) setTodo:(Todo *)newTodo;

@end
