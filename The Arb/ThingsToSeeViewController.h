//
//  ThingsToSeeViewController.h
//  The Arb
//
//  Created by Riley Lundquist on 7/18/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArbItemInfo.h"

@interface ThingsToSeeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
