//
//  KeyRequestViewController.m
//  Doorman
//
//  Created by Ian Harris on 06/08/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "KeyRequestViewController.h"

@interface KeyRequestViewController ()

@end

@implementation KeyRequestViewController

@synthesize KeyRequestDatePicker;
id<DoormanSendKeyRequestResultSender> rs;
KeyRequest *kr;

- (void)setKeyRequest:(KeyRequest *)_kr
{
    kr = _kr;
}

- (void)setResultSender:(id<DoormanSendKeyRequestResultSender>) _rs
{
    rs = _rs;
}

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
    KeyRequestDatePicker.backgroundColor= [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)issueKeys:(id)sender {
    // need to extract the date from datePicker
    NSDate *mDate = [KeyRequestDatePicker date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:mDate];
    
    KeyResponse *keyResponse;
    keyResponse = [[KeyResponse alloc] init];
    [keyResponse setCode:@"200"];
    [keyResponse setUname:[kr getSenderId]];
    [keyResponse setDay:[comps day]];
    [keyResponse setMonth:[comps month]];
    [keyResponse setYear:[comps year]];
    [rs successWithResult:keyResponse];
    
    [self performSegueWithIdentifier:@"UnwindKeyRequestSegue" sender:nil];
}

- (IBAction)denyKeys:(id)sender {
    KeyResponse *keyResponse;
    keyResponse = [[KeyResponse alloc] init];
    [keyResponse setCode:@"400"];
    [keyResponse setUname:[kr getSenderId]];
    [rs successWithResult:keyResponse];
    
    [self performSegueWithIdentifier:@"UnwindKeyRequestSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
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
