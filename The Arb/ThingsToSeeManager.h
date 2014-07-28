//
//  ThingsToSeeManager.h
//  The Arb
//
//  Created by Riley Lundquist on 7/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArbItemInfo.h"

@interface ThingsToSeeManager : NSObject

@property (strong, nonatomic) NSMutableArray *items;

+(instancetype)getInstance;

-(void)loadInfo;

@end
