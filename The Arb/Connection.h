//
//  Connection.h
//  The Arb
//
//  Created by Riley Lundquist on 6/26/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connection : NSObject

+(NSData *)sendRequestFor:(NSString *)info;

+(void)sendEmailFrom:(NSString *)email subject:(NSString *)subject message:(NSString *)message;

+(UIImage *)loadImageWithName:(NSString *)url;

@end
