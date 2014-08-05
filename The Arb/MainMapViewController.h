//
//  MainMapViewController.h
//  The Arb
//
//  Created by Riley Lundquist on 6/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Googlemaps/GoogleMaps.h>
#import "ArbItemInfo.h"

@interface MainMapViewController : UIViewController<GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (strong, nonatomic) ArbItemInfo *itemToAdd;

@end
