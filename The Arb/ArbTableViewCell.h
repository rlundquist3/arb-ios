//
//  ArbTableViewCell.h
//  The Arb
//
//  Created by Riley Lundquist on 7/18/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArbItemInfo.h"

@interface ArbTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *expandButton;

-(void)setUpWithItem:(ArbItemInfo *)item;

@end
