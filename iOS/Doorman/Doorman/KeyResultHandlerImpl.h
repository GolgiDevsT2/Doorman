//
//  KeyResultHandlerImpl.h
//  Doorman
//
//  Created by Ian Harris on 30/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoormanSvcGen.h"
#import "gdmViewController.h"

@interface KeyResultHandlerImpl : NSObject <DoormanSendKeyRequestResultReceiver>

- (void)success;
- (void)successWithResult:(KeyResponse *)result;
- (void)failureWithGolgiException:(GolgiException *)golgiException;
- (id)initWithViewId:(id)vid;

@end
