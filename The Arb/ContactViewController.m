//
//  ContactViewController.m
//  The Arb
//
//  Created by Riley Lundquist on 7/24/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ContactViewController.h"
#import "Connection.h"
#import "Constants.h"
#import "MainMapViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ContactViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *subjectField;
@property (strong, nonatomic) IBOutlet UITextView *messageField;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ContactViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageSent:) name:NOTIFICATION_EMAIL_SENT object:nil];
    
    [_messageField.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_messageField.layer setBorderWidth:0.5];
    [_messageField.layer setCornerRadius:5];
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager startUpdatingLocation];
}

-(void)messageSent:(NSNotification *)notification {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thanks!" message:@"Your message has been sent. We'll get back to you soon." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)sendButtonPressed:(id)sender {
    //ADD VALIDATION
    [Connection sendEmailFrom:_emailField.text subject:_subjectField.text message:[NSString stringWithFormat:@"%@\n\nSent from location: %@", _messageField.text, _locationManager.location]];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
