//
//  VenuesService.m
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/12/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import "VenueService.h"

@implementation VenueService

- (void)searchWithDelegate:(NSObject<VenueDelegate> *)delegate
                 withQuery:(NSString *)query
             withLocation:(CLLocationCoordinate2D)location {
    NSMutableDictionary *params = [[[ NSMutableDictionary alloc] init] autorelease];
    [params setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Foursquare ClientId"] forKey:@"client_id"];
    [params setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Foursquare ClientSecret"] forKey:@"client_secret"];
    [params setObject:@"20130815" forKey:@"v"];
    [params setObject:[NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude] forKey:@"ll"];
    [params setObject:query forKey:@"query"];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"venues/search" parameters:params  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [delegate searchSuccess:[mappingResult array]];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [delegate searchFailure:[error localizedDescription]];
    }];
}

@end
