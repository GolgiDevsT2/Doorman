//
//  gdmViewController.h
//  Doorman
//
//  Created by Ian Harris on 24/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "DoormanSvcGen.h"
#import "AccessResultHandlerImpl.h"
#import "GolgiWrapper.h"
#import "KeyRequestViewController.h"

@interface gdmViewController : UIViewController <CLLocationManagerDelegate,AVAudioPlayerDelegate,DoormanSendKeyRequestRequestReceiver>

@property (weak, nonatomic) IBOutlet UIButton *AccessButton;

- (void)UIForAccessResult:(AccessResponse *)result;

@end
