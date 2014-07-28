//
//  ArbItemInfo.m
//  The Arb
//
//  Created by Riley Lundquist on 7/18/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ArbItemInfo.h"

@implementation ArbItemInfo

+(instancetype)create:(NSString *)title image:(UIImage *)image info:(NSString *)info location:(CLLocationCoordinate2D)location start:(NSString *)start end:(NSString *)end {
    ArbItemInfo *instance = [[ArbItemInfo alloc] init];
    [instance setTitle:title];
    [instance setImage:image];
    [instance setInfo:info];
    [instance setLocation:location];
    [instance setStart:start];
    [instance setEnd:end];
    
    return instance;
}

@end
