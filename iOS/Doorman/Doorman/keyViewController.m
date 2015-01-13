//
//  keyViewController.m
//  Doorman
//
//  Created by Ian Harris on 30/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "keyViewController.h"

@interface keyViewController ()

@end

@implementation keyViewController

@synthesize granterTextField, requesterTextField;

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
    requesterTextField.delegate = self;
    granterTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)loadDestinationVC:(id)sender {
    // check the granter e-mail address
    NSString *granter = granterTextField.text;
    NSString *requester = requesterTextField.text;
    NSString *usernameKey = @"username_preference";
    NSString *granterKey = @"granter_preference";
    GolgiWrapper *golgiWrapper;
    NSLog(@"Next button pushed");
    // check that they are both set
    if([granter isEqualToString:@""] || [requester isEqualToString:@""]){
        // don't proceed need more info
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unset field"
                                                          message:@"Please complete all fields"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    else{
        NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
        [preferences setObject:requester forKey:usernameKey];
        [preferences setObject:granter forKey:granterKey];
        [preferences synchronize];
        NSLog(@"Attempting to allocate golgiWrapper");
        golgiWrapper = [[GolgiWrapper alloc] init];
        NSLog(@"Allocated golgiWrapper");
    }
    
    // check if this is a staff request
    if([granter isEqualToString:@"doorman@openmindnetworks.com"]){
        [self performSegueWithIdentifier:@"StaffSegue" sender:nil];
    }
    else{
        [self performSegueWithIdentifier:@"VisitorSegue" sender:nil];
    }
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
