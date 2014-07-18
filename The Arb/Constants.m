//
//  Constants.m
//  The Arb
//
//  Created by Riley Lundquist on 6/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const SERVER_ADDRESS = @"192.168.1.102";
NSString *const SERVER_PORT = @"8888";

NSString *const SEGUE_MAIN_MAP = @"SegueMainMap";
NSString *const SEGUE_THINGS_TO_SEE = @"ThingsToSeeSegue";

NSString *const CORE_DATA_TABLE_TRAILS = @"TrailMO";
NSString *const CORE_DATA_TABLE_TRAIL_POINTS = @"TrailPointMO";

NSString *const TRAILS_TABLE_COLUMN_NAME = @"name";
NSString *const TRAILS_TABLE_COLUMN_COLOR = @"color";
NSString *const TRAILS_TABLE_COLUMN_TRAIL_ID = @"trail_id";
NSString *const TRAILS_TABLE_COLUMN_POLYLINE = @"polyline";

NSString *const TRAIL_POINTS_TABLE_COLUMN_POINT_ID = @"point_id";
NSString *const TRAIL_POINTS_TABLE_COLUMN_TRAIL_ID = @"trail_id";
NSString *const TRAIL_POINTS_TABLE_COLUMN_LATITUDE = @"latitude";
NSString *const TRAIL_POINTS_TABLE_COLUMN_LONGITUDE = @"longitude";

NSString *const NOTIFICATION_TRAILS_LOADED = @"trails_loaded";
NSString *const NOTIFICATION_BOUNDARY_LOADED = @"boundary_loaded";

@end
