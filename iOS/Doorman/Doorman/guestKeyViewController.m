//
//  guestKeyViewController.m
//  Doorman
//
//  Created by Ian Harris on 06/08/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "guestKeyViewController.h"

@interface guestKeyViewController ()

@end

@implementation guestKeyViewController

@synthesize datePicker;

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
    // Do any additional setup after loading the view.
    datePicker.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue called in staffKeyViewController");
    NSUserDefaults *preferences;
    NSString *username;
    NSString *granter_name;
    NSString *usernameKey = @"username_preference";
    NSString *granterKey = @"granter_preference";
    
    // need to extract the date from datePicker
    NSDate *mDate = [datePicker date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:mDate];
    
    preferences = [NSUserDefaults standardUserDefaults];
    username = [preferences objectForKey:usernameKey];
    granter_name = [preferences objectForKey:granterKey];
    
    KeyRequest *keyRequest;
    keyRequest = [[KeyRequest alloc] init];
    [keyRequest setRequestId:granter_name];
    [keyRequest setSenderId:username];
    [keyRequest setDay:[comps day]];
    [keyRequest setMonth:[comps month]];
    [keyRequest setYear:[comps year]];
    NSLog(@"Day: %ld Month: %ld Year: %ld",(long)[keyRequest getDay],(long)[keyRequest getMonth],(long)[keyRequest getYear]);
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
