//
//  KeyRequestViewController.h
//  Doorman
//
//  Created by Ian Harris on 06/08/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoormanSvcGen.h"

@interface KeyRequestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *KeyRequestDatePicker;
- (void)setResultSender:(id<DoormanSendKeyRequestResultSender>) _rs;
- (void)setKeyRequest:(KeyRequest *) _kr;

@end
