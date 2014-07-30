//
//  ArbItemInfo.m
//  The Arb
//
//  Created by Riley Lundquist on 7/18/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ArbItemInfo.h"

@implementation ArbItemInfo

+(instancetype)create:(NSString *)title image:(UIImage *)image info:(NSString *)info latitude:(NSString *)latitude longitude:(NSString *)longitude start:(NSString *)start end:(NSString *)end {
    ArbItemInfo *instance = [[ArbItemInfo alloc] init];
    [instance setTitle:title];
    [instance setImage:image];
    [instance setInfo:info];
    [instance setLatitude:latitude];
    [instance setLongitude:longitude];
    [instance setStart:start];
    [instance setEnd:end];
    
    return instance;
}

@end
