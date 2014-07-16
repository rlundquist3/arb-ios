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
@property (strong, nonatomic) UIView *greyView;

@end

@implementation MainMapViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayTrails:) name:NOTIFICATION_TRAILS_LOADED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayBoundary:) name:NOTIFICATION_BOUNDARY_LOADED object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[DataLoader sharedLoader] getTrails];
    });
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[DataLoader sharedLoader] getBoundary];
    });*/
    
    _arbCoordinates = CLLocationCoordinate2DMake(42.293469, -85.699842);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_arbCoordinates.latitude longitude:_arbCoordinates.longitude zoom:15];
    
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    [_mapView setMapType:kGMSTypeHybrid];
    self.view = _mapView;
    
    [self displayBenches];
    
    _menuTableView = [[UITableView alloc] init];
    _menuTableView.hidden = YES;
    [_menuTableView setDataSource:self];
    [_menuTableView setDelegate:self];
    [self.view addSubview:_menuTableView];
    
    _greyView = [[UIView alloc] initWithFrame:CGRectZero];
    [_greyView setUserInteractionEnabled:NO];
    [_greyView setBackgroundColor:[UIColor blackColor]];
    [_greyView setAlpha:0.0];
    [self.view addSubview:_greyView];
    [self.view bringSubviewToFront:_menuTableView];
}

-(void)showMenu {
    
    CGRect menuFrame = CGRectMake(0, 0, self.view.frame.size.width*2/3, self.view.frame.size.height);
    
    _menuTableView.hidden = NO;
    _greyView.frame = self.view.frame;
    
    [UIView animateWithDuration:.5
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:3.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _greyView.alpha = 0.5;
                         _menuTableView.frame = menuFrame;
                     }
                     completion:^(BOOL finished){
                         [_mapView setUserInteractionEnabled:NO];
                     }];
    [UIView commitAnimations];
}

-(void)hideMenu {
    
    [UIView animateWithDuration:.5
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _greyView.alpha = 0;
                         _menuTableView.center = CGPointMake(_menuTableView.center.x, -1 * _menuTableView.frame.size.height/2);
                     }
                     completion:^(BOOL finished){
                         _greyView.frame = CGRectZero;
                         _menuTableView.hidden = YES;
                         [_mapView setUserInteractionEnabled:YES];
                     }];
    [UIView commitAnimations];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

-(void)displayTrails:(NSNotification *)notification {
    NSDictionary *paths = notification.userInfo;
    
    NSEnumerator *enumerator = [paths keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        GMSPath *path = [paths objectForKey:key];
        GMSPolyline *trail = [GMSPolyline polylineWithPath:path];
        [trail setStrokeColor:[StyleManager getGreenColor]];
        [trail setStrokeWidth:2];
        [trail setMap:_mapView];
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

-(void)displayBenches {
    CLLocationCoordinate2D pos1 = CLLocationCoordinate2DMake(42.290786142013935, -85.705077703266625);
    CLLocationCoordinate2D pos2 = CLLocationCoordinate2DMake(42.292032317894687, -85.696026630823411);
    CLLocationCoordinate2D pos3 = CLLocationCoordinate2DMake(42.289126118386392, -85.69697989054292);
    CLLocationCoordinate2D pos4 = CLLocationCoordinate2DMake(42.292445897949968, -85.702774486370188);
    
    GMSMarker *bench1 = [GMSMarker markerWithPosition:pos1];
    GMSMarker *bench2 = [GMSMarker markerWithPosition:pos2];
    GMSMarker *bench3 = [GMSMarker markerWithPosition:pos3];
    GMSMarker *bench4 = [GMSMarker markerWithPosition:pos4];
    NSArray *benches = [[NSArray alloc] initWithObjects:bench1, bench2, bench3, bench4, nil];
    
    for (GMSMarker *bench in benches) {
        [bench setAppearAnimation:kGMSMarkerAnimationPop];
        [bench setMap:_mapView];
    }
    
    /*GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:pos1];
    [path addCoordinate:pos2];
    [path addCoordinate:pos3];
    [path addCoordinate:pos4];
    GMSPolyline *boundary = [GMSPolyline polylineWithPath:path];
    boundary.map = _mapView;*/
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
