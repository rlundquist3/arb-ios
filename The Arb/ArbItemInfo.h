//
//  ArbItemInfo.h
//  The Arb
//
//  Created by Riley Lundquist on 7/18/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArbItemInfo : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *info;

+(instancetype)create:(NSString *)title image:(UIImage *)image info:(NSString *)info;

@end
