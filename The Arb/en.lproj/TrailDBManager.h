//
//  TrailDBManager.h
//  The Arb
//
//  Created by Riley Lundquist on 6/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TrailMO.h"
#import "TrailPointMO.h"
#import "AppDelegate.h"
#import <Googlemaps/GoogleMaps.h>

@interface TrailDBManager : NSObject

+(TrailMO *)insert:(NSString *)name color:(NSNumber *)color trail_id:(NSNumber *)trail_id polyline:(GMSPolyline *)polyline;

+(BOOL)hasTrails;

+(NSArray *)getAllTrails;
+(TrailMO *)getTrailWithID:(NSNumber *)trail_id;
+(TrailMO *)getTrailWithName:(NSString *)name;

+(TrailPointMO *)insert:(NSNumber *)point_id trail_id:(NSString *)trail_id latitude:(NSString *)latitude longitude:(NSString *)longitude;

+(TrailPointMO *)getTrailPointWithID:(NSNumber *)point_id;
+(BOOL)isPopulated;
+(NSUInteger)numberOfPoints;
+(NSArray *)getAllPoints;
+(NSArray *)getAllPointsForTrail:(NSNumber *)trail_id;
+(NSArray *)getAllPointsForTrailWithName:(NSString *)name;

@end
