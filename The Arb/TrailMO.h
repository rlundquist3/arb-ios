//
//  TrailMO.h
//  The Arb
//
//  Created by Riley Lundquist on 7/16/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TrailPointMO;

@interface TrailMO : NSManagedObject<NSCoding>

@property (nonatomic, retain) NSNumber * color;
@property (nonatomic, retain) NSNumber * trail_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id polyline;
@property (nonatomic, retain) TrailPointMO *trail;

@end
