//
//  ThingsToSeeManager.m
//  The Arb
//
//  Created by Riley Lundquist on 7/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ThingsToSeeManager.h"
#import "Connection.h"

static ThingsToSeeManager *selfInstance;

@implementation ThingsToSeeManager

+ (instancetype) getInstance {
    @synchronized(self) {
        if(selfInstance == nil) {
            selfInstance = [[self alloc] init];
            [selfInstance setItems:[[NSMutableArray alloc] initWithCapacity:100]];
        }
    }
    return selfInstance;
}

-(void)loadInfo {
    NSData *data = [Connection sendRequestFor:@"arb_items"];
    NSString *xml = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"Item Data: %@", xml);
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<item><name>(.+)<\\/name><image>(.+)<\\/image><description>(.+)<\\/description><coords><lat>(-?\\d+\\.\\d+)<\\/lat><lon>(-?\\d+\\.\\d+)<\\/lon><\\/coords><dates><start>(.+)<\\/start><end>(.+)<\\/end><\\/dates><\\/item>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:xml options:0 range:NSMakeRange(0, xml.length)];
    
    NSString *name, *image, *info, *latitude, *longitude, *start, *end;
    for(NSTextCheckingResult *match in matches) {
        name = [xml substringWithRange:[match rangeAtIndex:1]];
        image = [xml substringWithRange:[match rangeAtIndex:2]];
        info = [xml substringWithRange:[match rangeAtIndex:3]];
        latitude = [xml substringWithRange:[match rangeAtIndex:4]];
        longitude = [xml substringWithRange:[match rangeAtIndex:5]];
        start = [xml substringWithRange:[match rangeAtIndex:6]];
        end = [xml substringWithRange:[match rangeAtIndex:7]];
        
        ArbItemInfo *item = [ArbItemInfo create:name image:nil/*[UIImage imageNamed:image]*/ info:info latitude:latitude longitude:longitude start:start end:end];
        NSLog(@"Item: %@", item.title);
        
        [_items addObject:item];
    }
}

@end
