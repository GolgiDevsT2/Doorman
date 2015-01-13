//
//  staffKeyViewController.m
//  Doorman
//
//  Created by Ian Harris on 30/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "staffKeyViewController.h"

@interface staffKeyViewController ()

@end

@implementation staffKeyViewController

@synthesize keyRequestButton,pinTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pinTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *pin = textView.text;
    if(pin != nil && [pin length] > 0){
        [keyRequestButton setEnabled:YES];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 160; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

// Hides Keyboard when return is pressed in a Textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue called in staffKeyViewController");
    NSUserDefaults *preferences;
    NSString *username;
    NSString *granter_name;
    NSString *usernameKey = @"username_preference";
    NSString *granterKey = @"granter_preference";
    
    preferences = [NSUserDefaults standardUserDefaults];
    username = [preferences objectForKey:usernameKey];
    granter_name = [preferences objectForKey:granterKey];
    
    KeyRequest *keyRequest;
    keyRequest = [[KeyRequest alloc] init];
    [keyRequest setAuth:pinTextField.text];
    [keyRequest setRequestId:granter_name];
    [keyRequest setSenderId:username];
    [DoormanSvc sendSendKeyRequestUsingResultReceiver:[[KeyResultHandlerImpl alloc]initWithViewId:segue.destinationViewController] andDestination:@"doormanserver-uname" withReq:keyRequest];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
