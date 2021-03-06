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
//  gdmViewController.m
//  Doorman
//
//  Created by Ian Harris on 24/07/2014.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "gdmViewController.h"

@interface gdmViewController ()
@end

@implementation gdmViewController

@synthesize AccessButton;

AVAudioPlayer *player;
GolgiWrapper *golgiWrapper;
id<DoormanSendKeyRequestResultSender> rs;
KeyRequest *kr;

// class variables
CLLocationManager *locationManager = nil;

// call back for key request receiver
- (void)sendKeyRequestWithResultSender:(id<DoormanSendKeyRequestResultSender>)resultSender andReq:(KeyRequest *)req
{
    rs = resultSender;
    kr = req;
    [self performSegueWithIdentifier:@"VisitorKeySegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"VisitorKeySegue"]) {
        KeyRequestViewController *destViewController = segue.destinationViewController;
        [destViewController setResultSender:rs];
        [destViewController setKeyRequest:kr];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [DoormanSvc registerSendKeyRequestRequestReceiver:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Images/background.jpg"]];
    golgiWrapper = [[GolgiWrapper alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager){
        locationManager = [[CLLocationManager alloc] init];
        NSLog(@"Setting up location manager");
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            NSLog(@"Request authorization in use");
            [locationManager requestWhenInUseAuthorization];
            NSLog(@"Request authorization in use.. done");
        }
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"Received location update");
    
    // CLLocationDistance
    CLLocationDistance distance;
    
    // CLLocation for the office
    CLLocation *office;
    CLLocationDegrees latitude = 53.34378;
    CLLocationDegrees longitude = -6.24707;
    office = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        
        // stop updating the location - this is recent enough
        [manager stopUpdatingLocation];
        
        // let's write a log
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        
        // check if we are close enough to trigger the door
        distance = [location distanceFromLocation:office];
        if(distance < 500.0){
            // device is close enough send the message
            [self sendAccessRequestWkr:location];
        }
        else{
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Access Denied"
                                                              message:@"Your Location cannot be verified"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }
}

- (void)sendAccessRequestWkr:(CLLocation *)location
{
    // get username and key
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    NSString* usernameKey = @"username_preference";
    NSString* keyKey = @"password_preference";
    NSString* userName;
    NSString* key;
    
    if([preferences objectForKey:usernameKey] == nil)
    {
        //  Doesn't exist.
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Access Request Cancelled"
                                                          message:@"No username set"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    else
    {
        //  Get current level
        userName = [preferences stringForKey:usernameKey];
    }
    
    if([preferences objectForKey:keyKey] == nil){
        // Doesn't exist
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Access Request Cancelled"
                                                          message:@"No key set"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    else{
        key = [preferences stringForKey:keyKey];
    }
    
    NSLog(@"Access Request:username: [%@]:key: [%@]",userName,key);
    
    // call a send
    //NSString *destination = @"doormanserver-uname";
    AccessRequest *accessRequest;
    accessRequest = [[AccessRequest alloc] init];
    [accessRequest setUname:userName];
    [accessRequest setKey:key];
    [accessRequest setLat:[NSString stringWithFormat:@"%f", location.coordinate.latitude]];
    [accessRequest setLon:[NSString stringWithFormat:@"%f", location.coordinate.longitude]];
    [self addDateToAccessRequest:accessRequest];
    NSLog(@"Trying to send");
    [DoormanSvc sendSendAccessRequestUsingResultReceiver:[[AccessResultHandlerImpl alloc]initWithViewId:self] andDestination:@"doormanserver-uname" withReq:accessRequest];
    NSLog(@"Apparently I sent");
}

- (void)addDateToAccessRequest:(AccessRequest *)accessRequest
{
    // declarations
    NSDate *date;
    NSTimeInterval timeInterval;
    long long timeIntervalInteger;
    int val = 0;
    
    // create date and extract timeInterval
    date = [[NSDate alloc] init];
    timeInterval = [date timeIntervalSince1970];
    timeInterval *= 1000.0;
    timeIntervalInteger = (long long)timeInterval;
    
    // bitwise OR the timeIntervalInteger to get the lowest 4 bytes and set the TimeStampLow field
    val |= timeIntervalInteger;
    [accessRequest setTsl:val];
    
    // shift the timeIntervalInteger
    timeIntervalInteger >>= 32;
    // reset val for bitwise OR to get highest 4 bytes and set the TimeStampHigh field
    val = 0;
    val |= timeIntervalInteger;
    [accessRequest setTsh:val];
}

- (IBAction)sendAccessRequest:(id)sender {
    [self startStandardUpdates];
}

- (void)resetButtonImage:(NSTimer *)timer
{
    UIImage *btnImage = [UIImage imageNamed:@"pto_button.png"];
    [AccessButton setBackgroundImage:btnImage forState:UIControlStateNormal];
}

- (void)UIForAccessResult:(AccessResponse *)result
{
    if([[result getCode] isEqualToString:@"200"]){
        // button
        UIImage *btnImage = [UIImage imageNamed:@"do_button.png"];
        [AccessButton setBackgroundImage:btnImage forState:UIControlStateNormal];
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(resetButtonImage:)
                                       userInfo:nil
                                        repeats:NO];

        // audio
        NSError *mError;
        NSURL *audioURL = [NSURL fileURLWithPath: [[NSBundle mainBundle ] pathForResource:@"doorbuzzer" ofType:@"mp3" inDirectory: @"/"]];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&mError];
        player.volume = 0.5;
        if([player play]){
            NSLog(@"Apparently I played");
        }
    }
}

- (IBAction)unwindToBase:(UIStoryboardSegue *)unwindSegue
{
    NSLog(@"Unwound to base");
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
