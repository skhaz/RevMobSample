//
//  VenuesService.h
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/12/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import "VenueModel.h"

@protocol VenueDelegate

- (void) searchSuccess:(NSArray *)results;
- (void) searchFailure:(NSString *)message;

@end

@interface VenueService : NSObject

- (void)searchWithDelegate:(NSObject<VenueDelegate> *)delegate
                 withQuery:(NSString *)query
              withLocation:(CLLocationCoordinate2D)location;
@end
