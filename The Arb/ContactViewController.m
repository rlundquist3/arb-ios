//
//  ContactViewController.m
//  The Arb
//
//  Created by Riley Lundquist on 7/24/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ContactViewController.h"
#import "Connection.h"

@interface ContactViewController ()

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *subjectField;
@property (strong, nonatomic) IBOutlet UITextField *messageHint;
@property (strong, nonatomic) IBOutlet UITextView *messageField;

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
    // Do any additional setup after loading the view.
    
    _messageHint.frame = _messageField.frame;
    
}

- (IBAction)sendButtonPressed:(id)sender {
    //ADD VALIDATION
    [Connection sendEmailFrom:_emailField.text subject:_subjectField.text message:_messageField.text];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
