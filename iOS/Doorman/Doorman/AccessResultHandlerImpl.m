//
//  AccessResultHandlerImpl.m
//  Doorman
//
//  Created by Ian Harris on 25/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "AccessResultHandlerImpl.h"

@implementation AccessResultHandlerImpl

gdmViewController *viewId;

- (id)initWithViewId:(id)vid
{
    self = [super init];
    viewId = vid;
    return self;
}

- (void)success
{
    NSLog(@"AccessRequest success (no result)");
}

- (void)successWithResult:(AccessResponse *)result
{
    NSLog(@"AccessRequest successWithResult");
    [viewId UIForAccessResult:result];
}

- (void)failureWithGolgiException:(GolgiException *)golgiException
{
     NSLog(@"AccessRequest failureWithGolgiException");   
}

@end
