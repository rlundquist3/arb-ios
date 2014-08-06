//
//  Constants.h
//  The Arb
//
//  Created by Riley Lundquist on 6/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString *const SERVER_ADDRESS;
extern NSString *const SERVER_PORT;

extern NSString *const SEGUE_MAIN_MAP;
extern NSString *const SEGUE_THINGS_TO_SEE;
extern NSString *const SEGUE_CONTACT;
extern NSString *const SEGUE_HISTORY;
extern NSString *const SEGUE_EXPANDED_VIEW;
extern NSString *const SEGUE_ITEM_ON_MAP;
extern NSString *const SEGUE_BACK_TO_LIST;

extern NSString *const CORE_DATA_TABLE_TRAILS;
extern NSString *const CORE_DATA_TABLE_TRAIL_POINTS;

extern NSString *const TRAILS_TABLE_COLUMN_NAME;
extern NSString *const TRAILS_TABLE_COLUMN_TRAIL_ID;
extern NSString *const TRAILS_TABLE_COLUMN_PATH;

extern NSString *const TRAIL_POINTS_TABLE_COLUMN_POINT_ID;
extern NSString *const TRAIL_POINTS_TABLE_COLUMN_TRAIL_ID;
extern NSString *const TRAIL_POINTS_TABLE_COLUMN_LATITUDE;
extern NSString *const TRAIL_POINTS_TABLE_COLUMN_LONGITUDE;

extern NSString *const NOTIFICATION_TRAILS_LOADED;
extern NSString *const NOTIFICATION_BOUNDARY_LOADED;
extern NSString *const NOTIFICATION_EMAIL_SENT;

extern NSString *const MENU_ITEM_TRAILS;
extern NSString *const MENU_ITEM_BENCHES;
extern NSString *const MENU_ITEM_BOUNDARY;
extern NSString *const MENU_ITEM_THINGS_TO_SEE;
extern NSString *const MENU_ITEM_CONTACT;
extern NSString *const MENU_ITEM_HISTORY;
extern NSString *const MENU_ITEM_RESET;
extern NSString *const MENU_ITEM_CLEAR;

@end
