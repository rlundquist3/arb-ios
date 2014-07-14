//
//  DataLoader.h
//  The Arb
//
//  Created by Riley Lundquist on 7/2/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Googlemaps/GoogleMaps.h>

@interface DataLoader : NSObject<NSXMLParserDelegate>

+(DataLoader *)sharedLoader;

-(NSMutableDictionary *)getTrails;

@end
