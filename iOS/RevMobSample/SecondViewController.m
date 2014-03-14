//
//  SecondViewController.m
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/11/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(120, 40, 100, 20)] autorelease];
    [button setTitle:@"Fullscreen" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showFullscreen) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)showFullscreen
{
    RevMobFullscreen *fullscreen = [[RevMobAds session] fullscreen];
    
    [fullscreen loadWithSuccessHandler:^(RevMobFullscreen *fs) {
        [fullscreen showAd];
    } andLoadFailHandler:^(RevMobFullscreen *fs, NSError *error) {
        [[RevMobAds session] showPopup];
    }];
}

@end
