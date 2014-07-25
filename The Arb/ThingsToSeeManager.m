//
//  ThingsToSeeManager.m
//  The Arb
//
//  Created by Riley Lundquist on 7/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ThingsToSeeManager.h"

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

@end
