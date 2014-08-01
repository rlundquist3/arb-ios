//
//  ArbItemInfo.h
//  The Arb
//
//  Created by Riley Lundquist on 7/18/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ArbItemInfo : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *end;

+(instancetype)create:(NSString *)title imageName:(NSString *)imageName image:(UIImage *)image info:(NSString *)info latitude:(NSString *)latitude longitude:(NSString *)longitude start:(NSString *)start end:(NSString *)end;

@end
