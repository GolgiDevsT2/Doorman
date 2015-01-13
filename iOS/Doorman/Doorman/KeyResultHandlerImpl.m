//
//  KeyResultHandlerImpl.m
//  Doorman
//
//  Created by Ian Harris on 30/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "KeyResultHandlerImpl.h"

@implementation KeyResultHandlerImpl

gdmViewController *viewId;

- (id)initWithViewId:(id)vid
{
    self = [self init];
    viewId = vid;
    return self;
}

- (void)success
{
}

- (void)successWithResult:(KeyResponse *)result
{
    NSString* keyKey = @"password_preference";
    NSUserDefaults *preferences;
    preferences = [NSUserDefaults standardUserDefaults];
    
    [preferences setObject:[result getKey] forKey:keyKey];
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Key Request Response"
                                                      message:@"Key Issued"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

- (void)failureWithGolgiException:(GolgiException *)golgiException
{
}

@end
