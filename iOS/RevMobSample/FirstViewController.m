//
//  FirstViewController.m
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/11/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

@synthesize banner;
@synthesize mapView;
@synthesize locationManager;
@synthesize location;

@synthesize showButton;
@synthesize hideButton;
@synthesize foursquareButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mapView];
    
    locationManager = [CLLocationManager new];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    locationManager.delegate = self;
    
    [self.mapView.userLocation addObserver:self
                                forKeyPath:@"location"
                                   options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                                   context:NULL];
    
    self.showButton = [self createShowButton];
    self.hideButton = [self createHideButton];
    self.foursquareButton = [self createFoursquareButton];
    
    [self.view addSubview:self.showButton];
    [self.view addSubview:self.hideButton];
    [self.view addSubview:self.foursquareButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [locationManager startUpdatingLocation];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [locationManager stopUpdatingLocation];
    [super viewWillDisappear:animated];
}


- (UIButton *)createShowButton
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 40, 100, 20)] autorelease];
    [button setTitle:@"Show" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showBanner) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    return button;
}

- (UIButton *)createHideButton
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(100, 40, 100, 20)] autorelease];
    [button setTitle:@"Hide" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hideBanner) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    return button;
}

- (UIButton *)createFoursquareButton
{
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(200, 40, 100, 20)] autorelease];
    [button setTitle:@"Foursquare" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(invokeFoursquare) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    return button;
}

- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    // TODO
}

- (void)showBanner
{
    self.showButton.userInteractionEnabled = NO;
    self.banner = [[RevMobAds session] bannerView];
    self.banner.delegate = self;
    
    [self.banner loadAd];
}

- (void)hideBanner
{
    if (!self.banner)
        return;
    
    self.hideButton.userInteractionEnabled = NO;
    
    const CGFloat bannerHeight = self.banner.frame.size.height;
    const CGFloat bannerWidth = self.banner.frame.size.width;
    
    const CGFloat screenHeight = self.view.frame.size.height;
    const CGFloat screenWidth = self.view.frame.size.width;
    
    CGRect endFrame = CGRectMake(screenWidth / 2.0 - bannerWidth / 2.0,
                                 screenHeight, bannerWidth, bannerHeight);
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         [self.banner setFrame:endFrame];
                     }
                     completion:^(BOOL finished) {
                         [self.banner removeFromSuperview];
                         [self.banner release], self.banner = nil;
                         
                         self.showButton.userInteractionEnabled = YES;
                         
                         [[NSNotificationCenter defaultCenter] removeObserver:self];
                     }
     ];
}

- (void)invokeFoursquare
{
    [[VenueService new] searchWithDelegate:self
                                 withQuery:@"Revmob"
                              withLocation:self.location];
}

- (void)revmobAdDidFailWithError:(NSError *)error;
{
    [UIAlertView showWithTitle:@"Error"
                       message:[error localizedDescription]
             cancelButtonTitle:@"Ok"
             otherButtonTitles:nil
                      tapBlock:nil];
    
    [self.banner release], self.banner = nil;
}

- (void)revmobAdDidReceive;
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    
    const CGFloat bannerHeight = 50.0;
    const CGFloat bannerWidth = 320.0;
    
    const CGFloat screenHeight = self.view.frame.size.height;
    const CGFloat screenWidth = self.view.frame.size.width;
    
    CGRect startFrame = CGRectMake(screenWidth / 2.0 - bannerWidth / 2.0,
                                   screenHeight, bannerWidth, bannerHeight);
    
    CGRect endFrame = CGRectMake(screenWidth/2.0 - bannerWidth/2.0,
                                 (screenHeight) - (bannerHeight * 2),
                                 bannerWidth, bannerHeight);
    
    [self.banner setFrame:CGRectMake(0, 0, bannerWidth, bannerHeight)];
    [self.banner setFrame:startFrame];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         [self.banner setFrame:endFrame];
                         
                     }
                     completion:^(BOOL finished) {
                         self.hideButton.userInteractionEnabled = YES;
                     }
     ];
    
    [self.view addSubview:self.banner];
}

- (void)revmobAdDisplayed;
{
    NSLog(@"revmobAdDisplayed");
}

- (void)revmobUserClickedInTheAd;
{
    NSLog(@"revmobUserClickedInTheAd");
}

- (void)revmobUserClosedTheAd;
{
    NSLog(@"revmobUserClosedTheAd");
}

- (void) searchSuccess:(NSArray *)results
{
    MKCoordinateRegion region;
    region.center = self.location;
    
    MKCoordinateSpan span;
    span.latitudeDelta = 1;
    span.longitudeDelta = 1;
    region.span = span;
    
    [self.mapView setRegion:region animated:YES];
    [mapView removeAnnotations:[mapView annotations]];
    [mapView addAnnotations:results];
}

- (void) searchFailure:(NSString *)message
{
    [UIAlertView showWithTitle:@"Error"
                       message:message
             cancelButtonTitle:@"Ok"
             otherButtonTitles:nil
                      tapBlock:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.location = newLocation.coordinate;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    // TODO
}

-(void)dealloc
{
    [self.mapView.userLocation removeObserver:self forKeyPath:@"location"];
    [self.mapView removeFromSuperview];
    [mapView dealloc];
    [banner dealloc];
    [locationManager dealloc];
    
    [super dealloc];
}

@end
