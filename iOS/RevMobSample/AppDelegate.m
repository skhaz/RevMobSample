//
//  AppDelegate.m
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/11/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import "AppDelegate.h"

#import <RestKit/RestKit.h>
#import <RevMobAds/RevMobAds.h>

#import "RootViewController.h"

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [RevMobAds startSessionWithAppID:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"RevMob AppId"]];
    
    [RevMobAds session].testingMode = RevMobAdsTestingModeWithAds;
 
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
#if 1
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
#endif
    
    NSURL *baseURL = [NSURL URLWithString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Foursquare API"]];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    objectManager.operationQueue.maxConcurrentOperationCount= 5;
    [objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    [objectManager addResponseDescriptorsFromArray:[RKObjectManager sharedManager].responseDescriptors];
    [objectManager addRequestDescriptorsFromArray:[RKObjectManager sharedManager].requestDescriptors];
    [RKObjectManager setSharedManager:objectManager];
    
    RKResponseDescriptor *venueResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:VenueModel.mappingForRequestMappings
                                                 method:RKRequestMethodAny
                                            pathPattern:VenueModel.pathPattern
                                                keyPath:VenueModel.keyPath
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    [objectManager addResponseDescriptor:venueResponseDescriptor];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    RootViewController *root = [[[RootViewController alloc] initWithNibName:nil
                                                                    bundle:nil] autorelease];
    
    window.rootViewController = root;
    
    [self.window makeKeyAndVisible];

    return YES;
}
    
@end
