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
