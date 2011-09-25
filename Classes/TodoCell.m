//
//  TodoCell.m
//  todo
//
//  Created by synactive on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TodoCell.h"

static UIImage *priority1Image = nil;
static UIImage *priority2Image = nil;
static UIImage *priority3Image = nil;

@interface TodoCell()

-(UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor
						selectedColor:(UIColor *) selectedColor
							 fontSize:(CGFloat) fontSize
								 bold:(BOOL) bold;

@end


@implementation TodoCell

@synthesize todoTextLabel, todoPriorityLabel, todoStatusLabel, todoPriorityImageView;

+ (void) initialize {
	priority1Image = [[UIImage imageNamed:@"high.png"] retain];
	priority2Image = [[UIImage imageNamed:@"medium.png"] retain];
	priority3Image = [[UIImage imageNamed:@"low.png"] retain];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		UIView *myContentView = self.contentView;
		
		self.todoPriorityImageView = [[UIImageView alloc] initWithImage:priority1Image];
		[myContentView addSubview:self.todoPriorityImageView];
		[self.todoPriorityImageView release];
		
		self.todoTextLabel = [self newLabelWithPrimaryColor:[UIColor blackColor]
											  selectedColor:[UIColor whiteColor]
												   fontSize:14.0
													   bold:YES];
		self.todoTextLabel.textAlignment = UITextAlignmentLeft; // default
		[myContentView addSubview:self.todoTextLabel];
		[self.todoTextLabel release];
		
		self.todoPriorityLabel = [self newLabelWithPrimaryColor:[UIColor blackColor]
												  selectedColor:[UIColor whiteColor]
													   fontSize:10.0
														   bold:YES];
		self.todoPriorityLabel.textAlignment = UITextAlignmentRight;
		[myContentView addSubview:self.todoPriorityLabel];
		[self.todoPriorityLabel release];
		
		[myContentView bringSubviewToFront:self.todoPriorityImageView];
    }
    return self;

}

- (Todo *)todo {
    return todo;
}

- (void) setTodo:(Todo *) newTodo {
	todo = newTodo;
	self.todoTextLabel.text = newTodo.text;
	self.todoPriorityImageView.image = [self imageForPriority:newTodo.priority];
	
	if (newTodo.priority == 1) {
		self.todoPriorityLabel.text = @"Low";
	}
	else if(newTodo.priority == 2) {
		self.todoPriorityLabel.text = @"Medium";
	}
	else {
		self.todoPriorityLabel.text = @"High";
	}
	[self setNeedsDisplay];
}

- (void) layoutSubviews {
#define LEFT_COLUMN_OFFSET 1
#define LEFT_COLUMN_WIDTH 50
	
#define RIGHT_COLUMN_OFFSET 75
#define RIGHT_COLUMN_WIDTH 240
	
#define UPPER_ROW_TOP 4
	
	[super layoutSubviews];
	CGRect contentRect = self.contentView.bounds;
	
	if (!self.editing) {
		CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
		
		frame = CGRectMake(boundsX+RIGHT_COLUMN_OFFSET, UPPER_ROW_TOP, RIGHT_COLUMN_WIDTH, 13);
		frame.origin.y = 15;
		self.todoTextLabel.frame = frame;
		
		UIImageView *imageView = self.todoPriorityImageView;
		frame = [imageView frame];
		frame.origin.x = boundsX +LEFT_COLUMN_OFFSET;
		frame.origin.y = 10;
		imageView.frame = frame;
		
		CGSize prioritySize = [self.todoPriorityLabel.text sizeWithFont:self.todoPriorityLabel.font
															   forWidth:RIGHT_COLUMN_WIDTH
														  lineBreakMode:UILineBreakModeTailTruncation];
		CGFloat priorityX = frame.origin.x +imageView.frame.size.width + 8.0;
		frame = CGRectMake(priorityX, UPPER_ROW_TOP, prioritySize.width, prioritySize.height);
		frame.origin.y = 15;
		self.todoPriorityLabel.frame = frame;
	}
}

- (void)setSelected:(BOOL)select animated:(BOOL)animated {
	
	[super setSelected:select animated:animated];
	
	UIColor *backgroundColor = nil;
	if (select) {
		backgroundColor = [UIColor clearColor];
	} else {
		backgroundColor = [UIColor whiteColor];
	}
	
	
	self.todoTextLabel.backgroundColor = backgroundColor;
	self.todoPriorityLabel.backgroundColor = backgroundColor;
	
	self.todoTextLabel.highlighted = select;
	self.todoPriorityLabel.highlighted = select;
	
	self.todoTextLabel.opaque = !select;
	self.todoPriorityLabel.opaque = !select;
}

- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor
						 selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold {
	UIFont *font;
	if (bold) {
		font = [UIFont boldSystemFontOfSize:fontSize];
	} else {
		font = [UIFont systemFontOfSize:fontSize];
	}
	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}

- (UIImage *) imageForPriority:(NSInteger)priority {
	if (priority == 3) {
		return priority1Image;
	} else if (priority == 2) {
		return priority2Image;
	} else {
		return priority3Image;
	}
	
	return nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
