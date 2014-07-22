//
//  TrailPointMO.h
//  The Arb
//
//  Created by Riley Lundquist on 6/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TrailMO.h"

@interface TrailPointMO : NSManagedObject

@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
//@property (nonatomic, retain) NSNumber * trail_id;
@property (nonatomic, retain) NSString * trail_id;
@property (nonatomic, retain) NSNumber * point_id;
@property (nonatomic, retain) TrailMO* trail;

@end
