//
//  FoursquareModel.h
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/12/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <RestKit/RestKit.h>

@interface VenueModel : UIView <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, retain, setter = setLocation:) CLLocation* location;

+ (RKObjectMapping *)mappingForRequestMappings;
+ (NSString *)pathPattern;
+ (NSString *)keyPath;

@end
