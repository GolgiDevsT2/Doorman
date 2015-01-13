//
//  GolgiStuff.m
//  Doorman
//
//  Created by Ian Harris on 31/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//


#import "GolgiWrapper.h"

@implementation GolgiWrapper

// GOLGI
//********************************* Registration ***************************
//
// Setup handling of inbound SendMessage methods and then Register with Golgi
//
- (void)doGolgiRegistration
{
    //
    // Do this before registration because on registering, there may be messages queued
    // up for us that would arrive and be rejected because there is no handler in place
    //
    
    // [TapTelegraphSvc registerSendMessageRequestReceiver:self];
    
    //
    // and now do the main registration with the service
    //
    NSLog(@"Registering with golgiId: '%@'", ourId);
    // [Golgi setOption:@"USE_DEV_CLUSTER" withValue:@"0"];
    
    [Golgi registerWithDevId:DOORMAN_DEV_KEY
                       appId:DOORMAN_APP_KEY
                      instId:ourId
                  andAPIUser:self];
}

//- (void)doGolgiRegistrationWithOurId:(NSString *)_ourId
//{
//    NSString *username_key = @"username_preference";
//    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
//    
//    ourId = _ourId;
//    [preferences setObject:ourId forKey:username_key];
//    [preferences synchronize];
//    [self doGolgiRegistration];
//}

//
// Registration worked
//

- (void)golgiRegistrationSuccess
{
    NSLog(@"Golgi Registration: PASS");    
}

//
// Registration failed
//

- (void)golgiRegistrationFailure:(NSString *)errorText
{
    NSLog(@"Golgi Registration: FAIL => '%@'", errorText);
}

- (void)setPushId:(NSString *)_pushId
{
    if([pushId  compare:_pushId] != NSOrderedSame){
        pushId = _pushId;
        [self doGolgiRegistration];
    }
}

- (NSString *)pushTokenToString:(NSData *)token
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    
    for(int i = 0; i < token.length; i++){
        [hexStr appendFormat:@"%02x", ((unsigned char *)[token bytes])[i]];
    }
    
    return [NSString stringWithString:hexStr];
}

- (GolgiWrapper *)init
{
    NSLog(@"Initialising GolgiWrapper");
    NSString *username_key = @"username_preference";
    
    self = [super init];
    
    NSLog(@"Before ourId retrieval");
    ourId = [[NSUserDefaults standardUserDefaults] objectForKey:username_key];
    NSLog(@"After ourId retrieval");
    if(ourId == nil || ourId.length == 0){
        NSLog(@"Display warning message block");
        // prompt user that a key is required
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to register"
                                                          message:@"No key set"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return self;
    }

    NSLog(@"After warning message block");
    NSLog(@"Instance Id: '%@'", ourId);
    
    pushId = @"";
    
    [self doGolgiRegistration];
    
    return self;
}


@end
