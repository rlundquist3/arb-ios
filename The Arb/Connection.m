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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/Arb/main.php?type=%@", SERVER_ADDRESS, SERVER_PORT, type]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

+(void)sendEmailFrom:(NSString *)email subject:(NSString *)subject message:(NSString *)message {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/Arb/mail.php", SERVER_ADDRESS, SERVER_PORT]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"email=%@&subject=%@&message=%@", email, subject, message];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
