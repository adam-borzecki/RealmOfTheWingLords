//
//  Shell.m
//  RealmOfTheWingLords
//
//  Created by Adam Borzecki on 2013-08-21.
//  Copyright (c) 2013 Adam Borzecki. All rights reserved.
//

#import "Shell.h"
#import "NameListView.h"

@implementation Shell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self addSubview:[[NameListView alloc] initWithFrame:frame]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
