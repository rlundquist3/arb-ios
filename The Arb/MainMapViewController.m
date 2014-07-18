//
//  MainMapViewController.m
//  The Arb
//
//  Created by Riley Lundquist on 6/25/14.
//  Copyright (c) 2014 Riley Lundquist. All rights reserved.
//

#import "MainMapViewController.h"
#import "DataLoader.h"
#import "StyleManager.h"
#import "Constants.h"

@interface MainMapViewController ()

@property (strong, nonatomic) GMSMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D arbCoordinates;
@property (strong, nonatomic) UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UIView *titleBar;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) UIView *greyView;
@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) NSMutableArray *trails;
@property (strong, nonatomic) NSArray *benches;

@end

@implementation MainMapViewController

BOOL trailsOn = NO, benchesOn = NO;

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
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupTrails:) name:NOTIFICATION_TRAILS_LOADED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayBoundary:) name:NOTIFICATION_BOUNDARY_LOADED object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[DataLoader sharedLoader] getTrails];
    });
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
     [[DataLoader sharedLoader] getBoundary];
     });*/
    
    _arbCoordinates = CLLocationCoordinate2DMake(42.293469, -85.699842);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_arbCoordinates.latitude longitude:_arbCoordinates.longitude zoom:15];
    
    //[self.view addSubview:_titleBar];
    
    _mapView = [GMSMapView mapWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    [_mapView setMapType:kGMSTypeHybrid];
    [self.view addSubview:_mapView];
    
    [self setupBenches];
    
    _menuTableView = [[UITableView alloc] init];
    _menuTableView.hidden = YES;
    _menuTableView.allowsMultipleSelection = YES;
    [_menuTableView setDataSource:self];
    [_menuTableView setDelegate:self];
    [_menuTableView setBackgroundColor:[StyleManager getBeigeColor]];
    [self.view addSubview:_menuTableView];
    
    _greyView = [[UIView alloc] initWithFrame:CGRectZero];
    [_greyView setUserInteractionEnabled:NO];
    [_greyView setBackgroundColor:[UIColor blackColor]];
    [_greyView setAlpha:0.0];
    [self.view addSubview:_greyView];
    [self.view bringSubviewToFront:_menuTableView];
    
    _menuItems = [[NSArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"Trails", @"Benches", nil], [[NSArray alloc] initWithObjects:@"Things to See", nil], nil];
}

- (IBAction)menuButtonClicked:(id)sender {
    if (_menuTableView.hidden) {
        [self showMenu];
        [_menuButton setImage:[UIImage imageNamed:@"arrow_filled"] forState:UIControlStateNormal];
    } else {
        [self hideMenu];
        [_menuButton setImage:[UIImage imageNamed:@"arrow_unfilled"] forState:UIControlStateNormal];
    }
}

-(void)showMenu {
    [_mapView setUserInteractionEnabled:NO];
    
    CGRect menuFrame = CGRectMake(0, 64, self.view.frame.size.width*2/3, self.view.frame.size.height-60);
    _menuTableView.frame = menuFrame;
    _menuTableView.hidden = NO;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_menuTableView.layer addAnimation:transition forKey:nil];
    
    _greyView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    [UIView animateWithDuration:.5
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:3.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _greyView.alpha = 0.5;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    [UIView commitAnimations];
}

-(void)hideMenu {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_menuTableView.layer addAnimation:transition forKey:nil];
    _menuTableView.hidden = YES;
    
    [_mapView setUserInteractionEnabled:YES];
    
    [UIView animateWithDuration:.5
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _greyView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         _greyView.frame = CGRectZero;
                     }];
    [UIView commitAnimations];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [StyleManager getBlueColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Map Options";
            break;
        case 1: return @"Actions";
        default: return @"";
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *item = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [_menuTableView cellForRowAtIndexPath:indexPath];
    
    if ([item isEqualToString:@"Trails"]) {
        [self trailsOn];
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark"]]];
    } else if ([item isEqualToString:@"Benches"]) {
        [self benchesOn];
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark"]]];
    } else if ([item isEqualToString:@"Things to See"]) {
        NSLog(@"Things to See clicked");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self performSegueWithIdentifier:SEGUE_THINGS_TO_SEE sender:self];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *item = [[_menuItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [_menuTableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryView:nil];
    
    if ([item isEqualToString:@"Trails"]) {
        [self trailsOff];
    } else if ([item isEqualToString:@"Benches"]) {
        [self benchesOff];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}

-(void)setupTrails:(NSNotification *)notification {
    NSDictionary *returnedTrails = notification.userInfo;
    _trails = [[NSMutableArray alloc] init];
    
    NSEnumerator *enumerator = [returnedTrails keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        GMSPolyline *trail = [returnedTrails objectForKey:key];
        [_trails addObject:trail];
    }
}

-(void)trailsOn {
    if (!trailsOn) {
        for (GMSPolyline *trail in _trails) {
            [trail setMap:_mapView];
        }
        trailsOn = YES;
    }
}

-(void)trailsOff {
    if (trailsOn) {
        for (GMSPolyline *trail in _trails) {
            [trail setMap:nil];
        }
        trailsOn = NO;
    }
}


-(void)displayBoundary:(NSNotification *)notification {
    /*GMSPath *path = [notification.userInfo objectForKey:@"boundary"];
    NSLog(@"Size: %d", path.count);
    GMSPolyline *boundary = [GMSPolyline polylineWithPath:path];
    //[boundary setStrokeColor:[StyleManager getYellowColor]];
    //[boundary setStrokeWidth:2];
    [boundary setMap:_mapView];*/
}

-(void)setupBenches {
    CLLocationCoordinate2D pos1 = CLLocationCoordinate2DMake(42.290786142013935, -85.705077703266625);
    CLLocationCoordinate2D pos2 = CLLocationCoordinate2DMake(42.292032317894687, -85.696026630823411);
    CLLocationCoordinate2D pos3 = CLLocationCoordinate2DMake(42.289126118386392, -85.69697989054292);
    CLLocationCoordinate2D pos4 = CLLocationCoordinate2DMake(42.292445897949968, -85.702774486370188);
    
    _benches = [[NSArray alloc] initWithObjects:[GMSMarker markerWithPosition:pos1], [GMSMarker markerWithPosition:pos2], [GMSMarker markerWithPosition:pos3], [GMSMarker markerWithPosition:pos4], nil];
    
    /*GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:pos1];
    [path addCoordinate:pos2];
    [path addCoordinate:pos3];
    [path addCoordinate:pos4];
    GMSPolyline *boundary = [GMSPolyline polylineWithPath:path];
    boundary.map = _mapView;*/
}

-(void)benchesOn {
    if (!benchesOn) {
        for (GMSMarker *bench in _benches) {
            [bench setAppearAnimation:kGMSMarkerAnimationPop];
            [bench setMap:_mapView];
        }
        benchesOn = YES;
    }
}

-(void)benchesOff {
    if (benchesOn) {
        for (GMSMarker *bench in _benches) {
            [bench setAppearAnimation:kGMSMarkerAnimationPop];
            [bench setMap:nil];
        }
        benchesOn = NO;
    }
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
