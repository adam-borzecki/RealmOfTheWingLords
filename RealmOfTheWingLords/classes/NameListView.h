//
//  NameListView.h
//  RealmOfTheWingLords
//
//  Created by Adam Borzecki on 2013-08-21.
//  Copyright (c) 2013 Adam Borzecki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameListView : UIView <UITableViewDelegate, UITableViewDataSource>
{
	UITableView *list;
	UIButton *confirmButton;
	NSArray *data;
}

@end
