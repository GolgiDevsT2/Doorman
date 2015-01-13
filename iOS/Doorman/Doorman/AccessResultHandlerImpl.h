//
//  AccessResultHandlerImpl.h
//  Doorman
//
//  Created by Ian Harris on 25/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoormanSvcGen.h"
#import "gdmViewController.h"

@interface AccessResultHandlerImpl : NSObject <DoormanSendAccessRequestResultReceiver>

- (void)success;
- (void)successWithResult:(AccessResponse *)result;
- (void)failureWithGolgiException:(GolgiException *)golgiException;
- (id)initWithViewId:(id)vid;

@end
