//
//  GolgiStuff.h
//  Doorman
//
//  Created by Ian Harris on 31/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoormanSvcGen.h"
#import "DOORMAN_KEYS.h"

@interface GolgiWrapper : NSObject <GolgiAPIUser>

{
    NSString *ourId;
    NSString *pushId;
}

//- (void)doGolgiRegistrationWithOurId:(NSString *)_ourId;
- (NSString *)pushTokenToString:(NSData *)token;
- (void)setPushId:(NSString *)_pushId;
- (GolgiWrapper *)init;

@end
