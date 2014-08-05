//
//  DataLoader.m
//  The Arb
//
//  Created by Riley Lundquist on 7/2/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "DataLoader.h"
#import "Connection.h"
#import "TrailDBManager.h"
#import "Constants.h"
#import "StyleManager.h"

@implementation DataLoader

static DataLoader *sharedDataLoader = nil;
long numberOfPoints = 0;

+ (DataLoader *)sharedLoader {
    if (sharedDataLoader == nil) {
        sharedDataLoader = [[super allocWithZone:NULL] init];
    }
    return sharedDataLoader;
}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}

-(void)getTrails {
    NSLog(@"Get Trails");
    if (![TrailDBManager hasTrails]) {
        [self loadTrails];
    } else {
        NSLog(@"DB has trails");
    }
    
    NSMutableDictionary *trailsDict = [[NSMutableDictionary alloc] init];
    NSArray *trails = [TrailDBManager getAllTrails];
    NSLog(@"%lu trails", trails.count);

    int i=0;
    for (TrailMO *trail in trails) {
        [trailsDict setObject:trail.path forKey:[NSNumber numberWithInt:i]];
        i++;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TRAILS_LOADED object:self userInfo:trailsDict];
}

-(void)loadTrails {
    NSLog(@"Load Trails");
    
    NSData *trailPointsResponse = [Connection sendRequestFor:@"trail_points"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:trailPointsResponse];
    [parser setDelegate:self];
    BOOL result = [parser parse];
     
    NSLog(@"Success? %d", result);
    
    NSMutableDictionary *paths = [[NSMutableDictionary alloc] init];
    NSArray *points = [TrailDBManager getAllPoints];

    for (TrailPointMO *point in points) {
        GMSMutablePath *path;
        if ((path = [paths objectForKey:point.trail_id]) == nil) {
            path = [[GMSMutablePath alloc] init];
            [paths setObject:path forKey:point.trail_id];
        }
        [path addLatitude:[point.latitude doubleValue] longitude:[point.longitude doubleValue]];
        NSLog(@"Point: %@, %@", point.latitude, point.longitude);
    }

    NSEnumerator *enumerator = [paths keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        GMSPath *path = [paths objectForKey:key];
        [TrailDBManager insert:nil trail_id:key path:[path encodedPath]];
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"rtept"]) {
        NSLog(@"Point %lu", numberOfPoints);
        [TrailDBManager insert:[NSNumber numberWithLong:numberOfPoints] trail_id:[attributeDict objectForKey:@"trail"] latitude:[attributeDict objectForKey:@"lat"] longitude:[attributeDict objectForKey:@"lon"]];
        numberOfPoints++;
    }
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Error: %@", parseError);
}

-(void)getBoundary {
    NSError *error = nil;
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"LAABoundary" ofType:@"csv"];
    NSString* fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSStringEncodingConversionAllowLossy error:&error];
    NSArray* lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    GMSMutablePath *path = [GMSMutablePath path];
    
    for(int i=1; i<lines.count; i++) {
        NSString* current = [lines objectAtIndex:i];
        NSArray* arr = [current componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSString *latitude = [[NSString alloc] initWithFormat:@"%@", [arr objectAtIndex:2]];
        NSString *longitude = [[NSString alloc] initWithFormat:@"%@", [arr objectAtIndex:1]];
        
        [path addLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
        NSLog(@"Border point: %@, %@", latitude, longitude);
    }
    
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:path, @"boundary", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_BOUNDARY_LOADED object:self userInfo:userInfo];
}


@end
