//
//  FoursquareModel.m
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/12/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import "VenueModel.h"

#import <RKCLLocationValueTransformer/RKCLLocationValueTransformer.h>

@implementation VenueModel

@synthesize location;
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

+ (RKObjectMapping *)mappingForRequestMappings
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[VenueModel class]];
    [mapping addAttributeMappingsFromDictionary:@{
        @"name" : @"title",
        @"location.address" : @"subtitle"
    }];

    RKAttributeMapping *attributeMapping = [RKAttributeMapping attributeMappingFromKeyPath:@"location" toKeyPath:@"location"];
    attributeMapping.valueTransformer = [RKCLLocationValueTransformer locationValueTransformerWithLatitudeKey:@"lat" longitudeKey:@"lng"];
    [mapping addPropertyMapping:attributeMapping];

    return mapping;
}

-(void)setLocation:(CLLocation *)value
{
    MKCoordinateRegion region = {
        { value.coordinate.latitude, value.coordinate.longitude },
        { 0.01f , 0.01f }
    };

    self.coordinate = region.center;
}

+ (NSString *)pathPattern
{
    return @"venues/search";
}

+(NSString *)keyPath
{
    return @"response.venues";
}

- (void)dealloc
{
    [title release];
    [subtitle release];
    
	[super dealloc];
}

@end
