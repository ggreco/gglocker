//
//  ListCell.m
//  gglocker
//
//  Created by gabry on 9/12/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell
@synthesize cellLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
