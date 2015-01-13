//
//  keyViewController.h
//  Doorman
//
//  Created by Ian Harris on 30/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GolgiWrapper.h"

@interface keyViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *requesterTextField;
@property (weak, nonatomic) IBOutlet UITextField *granterTextField;

@end
