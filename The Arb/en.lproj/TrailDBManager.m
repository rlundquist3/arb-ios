//
//  TrailDBManager.m
//  The Arb
//
//  Created by Riley Lundquist on 6/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "TrailDBManager.h"
#import "Constants.h"

@implementation TrailDBManager

//Trail methods

+(TrailMO *)insert:(NSString *)name trail_id:(NSNumber *)trail_id path:(NSString *)path {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    TrailMO *trail;
    trail = [self getTrailWithID:trail_id];
    
    if (trail == nil)
        trail = [NSEntityDescription insertNewObjectForEntityForName:CORE_DATA_TABLE_TRAILS inManagedObjectContext:moc];
    
    if (name != nil && trail.name == nil) {
        [trail setValue:name forKey:TRAILS_TABLE_COLUMN_NAME];
    }
    if (trail_id != nil && trail.trail_id == nil) {
        [trail setValue:trail_id forKey:TRAILS_TABLE_COLUMN_TRAIL_ID];
    }
    if (path != nil && trail.path == nil) {
        [trail setValue:path forKey:TRAILS_TABLE_COLUMN_PATH];
    }
    
    [delegate saveContext];
    return trail;
}

+(BOOL)hasTrails {
    return [self getAllTrails].count > 0;
}

+(NSArray *)getAllTrails {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:CORE_DATA_TABLE_TRAILS inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:TRAILS_TABLE_COLUMN_TRAIL_ID ascending:YES];
    [fetchRequest setSortDescriptors:@[sort]];
    
    NSError *error;
    NSArray *fetchedRecords = [moc executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

+(TrailMO *)getTrailWithID:(NSNumber *)trail_id {
    NSArray *fetchedData = [self makeFetchRequest:[NSString stringWithFormat:@"%@ = \"%@\"", TRAILS_TABLE_COLUMN_TRAIL_ID, trail_id] table:CORE_DATA_TABLE_TRAILS];
    if (fetchedData.count > 0) {
        return [fetchedData firstObject];
    }
    return nil;
}

+(TrailMO *)getTrailWithName:(NSString *)name {
    NSArray *fetchedData = [self makeFetchRequest:[NSString stringWithFormat:@"%@ = \"%@\"", TRAILS_TABLE_COLUMN_NAME, name] table:CORE_DATA_TABLE_TRAILS];
    if (fetchedData.count > 0) {
        return [fetchedData firstObject];
    }
    return nil;
}

//TrailPoint methods

+(TrailPointMO *)insert:(NSNumber *)point_id trail_id:(NSString *)trail_id latitude:(NSString *)latitude longitude:(NSString *)longitude {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    TrailPointMO *trailPoint;
    trailPoint = [self getTrailPointWithID:point_id];
    
    if (trailPoint == nil)
        trailPoint = [NSEntityDescription insertNewObjectForEntityForName:CORE_DATA_TABLE_TRAIL_POINTS inManagedObjectContext:moc];
    
    if (point_id != nil && trailPoint.point_id == nil) {
        [trailPoint setValue:point_id forKey:TRAIL_POINTS_TABLE_COLUMN_POINT_ID];
    }
    if (trail_id != nil && trailPoint.trail_id == nil) {
        [trailPoint setValue:trail_id forKey:TRAIL_POINTS_TABLE_COLUMN_TRAIL_ID];
    }
    if (latitude != nil && trailPoint.latitude == nil) {
        [trailPoint setValue:latitude forKey:TRAIL_POINTS_TABLE_COLUMN_LATITUDE];
    }
    if (longitude != nil && trailPoint.longitude == nil) {
        [trailPoint setValue:longitude forKey:TRAIL_POINTS_TABLE_COLUMN_LONGITUDE];
    }
    
    NSLog(@"TrailPoint inserted: %@, %@", trailPoint.latitude, trailPoint.longitude);
    
    [delegate saveContext];
    return trailPoint;
}

+(TrailPointMO *)getTrailPointWithID:(NSNumber *)point_id {
    NSArray *fetchedData = [self makeFetchRequest:[NSString stringWithFormat:@"%@ = \"%@\"", TRAIL_POINTS_TABLE_COLUMN_POINT_ID, point_id] table:CORE_DATA_TABLE_TRAIL_POINTS];
    if (fetchedData.count > 0) {
        return [fetchedData firstObject];
    }
    return nil;
}

+(NSArray *)getAllPoints {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:CORE_DATA_TABLE_TRAIL_POINTS inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:TRAIL_POINTS_TABLE_COLUMN_POINT_ID ascending:YES];
    [fetchRequest setSortDescriptors:@[sort]];
    
    NSError *error;
    NSArray *fetchedRecords = [moc executeFetchRequest:fetchRequest error:&error];
    NSLog(@"Fetched %d points", fetchedRecords.count);
    return fetchedRecords;
}

+(BOOL)isPopulated {
    return [[self getAllPoints] count] > 0;
}

+(NSUInteger)numberOfPoints {
    return [[self getAllPoints] count];
}

+(NSArray *)getAllPointsForTrail:(NSString *)trail_id {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:CORE_DATA_TABLE_TRAIL_POINTS inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:TRAIL_POINTS_TABLE_COLUMN_POINT_ID ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ = \"%@\"", TRAIL_POINTS_TABLE_COLUMN_TRAIL_ID, trail_id]];
    [fetchRequest setSortDescriptors:@[sort]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *fetchedRecords = [moc executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

+(NSArray *)getAllPointsForTrailWithName:(NSString *)name {
    TrailMO* trail = [self getTrailWithName:name];
    return [self getAllPointsForTrail:trail.trail_id];
}

+(NSArray*)makeFetchRequest:(NSString*)predicateString table:(NSString *)table moc:(NSManagedObjectContext *)moc {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: predicateString];
    [fetchRequest setPredicate:predicate];
    
    NSError* error;
    NSArray *fetchedRecords = [moc executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

+(NSArray*)makeFetchRequest:(NSString*)predicateString table:(NSString *)table {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    return [self makeFetchRequest:predicateString table:table moc:moc];
}

@end
