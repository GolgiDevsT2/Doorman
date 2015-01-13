//
//  staffKeyViewController.h
//  Doorman
//
//  Created by Ian Harris on 30/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gdmViewController.h"
#import "DoormanSvcGen.h"
#import "KeyResultHandlerImpl.h"

@interface staffKeyViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *pinTextField;
@property (weak, nonatomic) IBOutlet UIButton *keyRequestButton;

@end
