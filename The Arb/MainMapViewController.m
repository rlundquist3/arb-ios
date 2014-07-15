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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[DataLoader sharedLoader] getBoundary];
    });
    
    _arbCoordinates = CLLocationCoordinate2DMake(42.293469, -85.699842);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_arbCoordinates.latitude longitude:_arbCoordinates.longitude zoom:14];
    
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    [_mapView setMapType:kGMSTypeHybrid];
    self.view = _mapView;
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
    GMSPolyline *boundary = [GMSPolyline polylineWithPath:[notification.userInfo objectForKey:@"boundary"]];
    [boundary setStrokeColor:[StyleManager getYellowColor]];
    [boundary setStrokeWidth:2];
    [boundary setMap:_mapView];
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
