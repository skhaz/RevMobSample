//
//  RootViewController.m
//  RevMobSample
//
//  Created by Rodrigo Delduca on 3/11/14.
//  Copyright (c) 2014 Rodrigo Delduca. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize tabbar;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tabbar = [[UITabBarController alloc] init];
    
    FirstViewController *first = [[[FirstViewController alloc] init] autorelease];
    first.title = @"Banner";

    SecondViewController *second = [[[SecondViewController alloc] init] autorelease];
    second.title = @"Fullscreen";

    self.tabbar.viewControllers = [NSArray arrayWithObjects:first, second, nil];
    
    [self.view addSubview:self.tabbar.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [self.tabbar dealloc];
    
    [super dealloc];
}

@end
