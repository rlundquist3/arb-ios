//
//  TrailPointMO.h
//  The Arb
//
//  Created by Riley Lundquist on 7/22/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TrailPointMO : NSManagedObject

@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSNumber * point_id;
@property (nonatomic, retain) NSString * trail_id;

@end
