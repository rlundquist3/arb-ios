//
//  ArbItemExpandedViewController.m
//  The Arb
//
//  Created by Riley Lundquist on 7/28/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ArbItemExpandedViewController.h"

@interface ArbItemExpandedViewController ()

@property (strong, nonatomic) IBOutlet UILabel *header;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *description;

@end

@implementation ArbItemExpandedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_header setText:_item.title];
    [_description setText:_item.info];
    if (_item.image != nil) {
        [_imageView setImage:_item.image];
    } else {
        [_imageView setFrame:CGRectZero];
    }
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
