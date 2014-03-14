//
//  FirstViewController.h
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/11/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import <RevMobAds/RevMobAds.h>
#import <UIAlertView+Blocks/UIAlertView+Blocks.h>

#import "VenueService.h"
#import "VenueModel.h"

@interface FirstViewController : UIViewController <RevMobAdsDelegate, VenueDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic) CGRect bannerFrame;
@property (nonatomic, retain) RevMobBannerView *banner;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D location;

@property (nonatomic, retain) UIButton *showButton;
@property (nonatomic, retain) UIButton *hideButton;
@property (nonatomic, retain) UIButton *foursquareButton;

@end
