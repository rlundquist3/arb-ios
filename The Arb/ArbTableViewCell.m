//
//  ArbTableViewCell.m
//  The Arb
//
//  Created by Riley Lundquist on 7/18/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ArbTableViewCell.h"

@implementation ArbTableViewCell

@synthesize imageView = _imageView;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUpWithItem:(ArbItemInfo *)item {
    [_title setText:item.title];
    [_imageView setImage:item.image];
    [_textView setText:item.info];
}

- (IBAction)expandButtonPressed:(id)sender {
    //Get view controller and segue to detail page
    NSLog(@"Expand button pressed...segue to detail page");
}

@end
