//
//  NameListView.m
//  RealmOfTheWingLords
//
//  Created by Adam Borzecki on 2013-08-21.
//  Copyright (c) 2013 Adam Borzecki. All rights reserved.
//

#import "NameListView.h"
#import "NameListViewCell.h"

@implementation NameListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		data = [[NSArray arrayWithObjects:@"Rob", @"Ada", @"Jen", @"Sironi", @"Ani", @"Freda", @"Shim", @"Adam", @"Norm", @"Holly", @"Jay", @"Natalie", @"Richard", nil ] retain];
		
		CGRect listFrame = frame;
		listFrame.size.height -= 100;
		
        list = [[UITableView alloc] initWithFrame:listFrame style:UITableViewStylePlain];
		list.delegate = self;
		list.dataSource = self;
		list.allowsMultipleSelection = YES;
		[list reloadData];
		
		[self addSubview:list];
		
		confirmButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		confirmButton.frame = CGRectMake( 0, listFrame.size.height + 10, listFrame.size.width, 60 );
		[confirmButton setTitle:@"CONFIRM" forState:UIControlStateNormal];
		[self addSubview:confirmButton];
		
		[confirmButton addTarget:self action:@selector(confirmButtonStateChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Names";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
    if (cell == nil) {
        cell = [[NameListViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
	
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    return cell;
}

- (void) confirmButtonStateChange:(UIEvent *)event
{
	NSArray *selection = [list indexPathsForSelectedRows];
	if( [selection count] > 0 )
	{
		[self shuffleOrder:selection];
	}
}

- (void) shuffleOrder:(NSArray *)attendees
{
	NSMutableArray *names = [NSMutableArray arrayWithCapacity:[attendees count]];
	
	// 1.) Get the selection in the same order as data, since it is sorted in touch order
	NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
	attendees = [attendees sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
	[descriptor release];
	
	// 2.) Figure out which name is at that index
	for( int i = 0; i < [attendees count]; i++ )
	{
		NSIndexPath *indexPath = [attendees objectAtIndex:i];
		[names addObject:[data objectAtIndex:indexPath.row]];
	}
	
	// 3.) Remove first entry and put it last
	NSString *wingLord = [[names objectAtIndex:0] retain];
	[names removeObjectAtIndex:0];
	[names addObject:wingLord];
	[wingLord release];
	
	// 4.) Reinsert subset into original data array
	NSMutableArray *tempData = [NSMutableArray arrayWithArray:data];
	for( int i = 0; i < [attendees count]; i++ )
	{
		NSIndexPath *indexPath = [attendees objectAtIndex:i];
		[tempData replaceObjectAtIndex:indexPath.row withObject:[names objectAtIndex:i]];
	}
	
	[data release];
	data = [tempData retain];
	[list reloadData];
}

@end
