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

@implementation DataLoader

static DataLoader *sharedDataLoader = nil;

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

-(NSMutableDictionary *)getTrails {
    if (![TrailDBManager isPopulated]) {
        [self loadTrails];
    }
    
    NSMutableDictionary *paths = [[NSMutableDictionary alloc] init];
    NSArray *points = [TrailDBManager getAllPoints];
    
    NSLog(@"Number of points: %d", points.count);
    
    for (TrailPointMO *point in points) {
        GMSMutablePath *path;
        if ((path = [paths objectForKey:point.trail_id]) == nil) {
            NSLog(@"New path: %d", paths.count);
            path = [[GMSMutablePath alloc] init];
            [paths setObject:path forKey:point.trail_id];
        }
        NSLog(@"Path: %@", point.trail_id);
        [path addLatitude:[point.latitude doubleValue] longitude:[point.longitude doubleValue]];
    }
    
    return paths;
}

-(void)loadTrails {
    NSData *trailPointsResponse = [Connection makeRequestFor:@"trail_points"];
    /*NSString *responseString = [[NSString alloc] initWithData:trailPointsResponse encoding:NSASCIIStringEncoding];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"-?\\d+[.]\\d+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:responseString options:0 range:NSMakeRange(0, responseString.length)];
    
    NSTextCheckingResult *latMatch, *lonMatch;
    NSString *latString, *lonString;
    int entry = [TrailDBManager getAllPoints].count;
    for (int i=0; i<matches.count; i+=2) {
        latMatch = matches[i];
        lonMatch = matches[i+1];
        latString = [responseString substringWithRange:[latMatch rangeAtIndex:0]];
        lonString = [responseString substringWithRange:[lonMatch rangeAtIndex:0]];
        
        [TrailDBManager insert:[NSNumber numberWithInt:entry] trail_id:nil latitude:latString longitude:lonString];
        
        NSLog(@"Entry: %d", entry);
        entry++;
    }*/
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:trailPointsResponse];
    [parser setDelegate:self];
    BOOL result = [parser parse];
    
    NSLog(@"Success? %d", result);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    NSLog(@"Started element: %@", elementName);
    if ([elementName isEqualToString:@"rtept"]) {
        [TrailDBManager insert:[NSNumber numberWithUnsignedInteger:[TrailDBManager numberOfPoints]] trail_id:[attributeDict objectForKey:@"trail"] latitude:[attributeDict objectForKey:@"lat"] longitude:[attributeDict objectForKey:@"lon"]];
    }
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Error: %@", parseError);
}

@end
