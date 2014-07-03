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

+(GMSPolyline *)getTrails {
    if (![TrailDBManager isPopulated]) {
        [self loadTrails];
    }
    
    GMSMutablePath *path = [GMSMutablePath path];
    NSArray *points = [TrailDBManager getAllPoints];
    
    NSLog(@"Number of points: %d", points.count);
    
    for (TrailPointMO *point in points) {
        //NSLog(@"adding to path: %@, %@", point.latitude, point.longitude);
        [path addLatitude:[point.latitude doubleValue] longitude:[point.longitude doubleValue]];
    }
    
    return [GMSPolyline polylineWithPath:path];
}

+(void)loadTrails {
    NSData *trailPointsResponse = [Connection makeRequestFor:@"trail_points"];
    NSString *responseString = [[NSString alloc] initWithData:trailPointsResponse encoding:NSASCIIStringEncoding];
    
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
    }
}

@end
