//
//  Connection.m
//  The Arb
//
//  Created by Riley Lundquist on 6/26/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "Connection.h"
#import "Constants.h"

@implementation Connection

+(NSData *)makeRequestFor:(NSString *)type {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"192.168.1.102/main.php?type=%@", type]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

@end
