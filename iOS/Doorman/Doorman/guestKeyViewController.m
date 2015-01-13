//
// This Software (the "Software") is supplied to you by Openmind Networks
// Limited ("Openmind") your use, installation, modification or
// redistribution of this Software constitutes acceptance of this disclaimer.
// If you do not agree with the terms of this disclaimer, please do not use,
// install, modify or redistribute this Software.
//
// TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED ON AN
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER
// EXPRESS OR IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR
// CONDITIONS OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
// Each user of the Software is solely responsible for determining the
// appropriateness of using and distributing the Software and assumes all
// risks associated with use of the Software, including but not limited to
// the risks and costs of Software errors, compliance with applicable laws,
// damage to or loss of data, programs or equipment, and unavailability or
// interruption of operations.
//
// TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW OPENMIND SHALL NOT
// HAVE ANY LIABILITY FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, WITHOUT LIMITATION,
// LOST PROFITS, LOSS OF BUSINESS, LOSS OF USE, OR LOSS OF DATA), HOWSOEVER
// CAUSED UNDER ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
// WAY OUT OF THE USE OR DISTRIBUTION OF THE SOFTWARE, EVEN IF ADVISED OF
// THE POSSIBILITY OF SUCH DAMAGES.
//

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
