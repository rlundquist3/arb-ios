//
//  ThingsToSeeViewController.m
//  The Arb
//
//  Created by Riley Lundquist on 7/18/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "ThingsToSeeViewController.h"
#import "ArbTableViewCell.h"
#import "ThingsToSeeManager.h"
#import "StyleManager.h"

@interface ThingsToSeeViewController ()

@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation ThingsToSeeViewController

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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setSeparatorColor:[StyleManager getBlueColor]];
    [self.view addSubview:_tableView];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArbItemInfo *item = [[[ThingsToSeeManager getInstance] items] objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"ArbTableViewCell%@", item.title];
    ArbTableViewCell *cell = (ArbTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ArbTableViewCell" owner:self options:nil] firstObject];
        [cell setUpWithItem:item];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ThingsToSeeManager getInstance] items].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
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
