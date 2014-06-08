//
//  PostViewController.m
//  CodePath-Week1
//
//  Created by Joey Hiller on 6/5/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"View did load!");
    
    //HEADER
    //Create frame for header
    CGRect headerBar = CGRectMake(0, 0, 320, 65);
    //create view for header
    UIView *headerView = [[UIView alloc] initWithFrame:headerBar];

    //declare image
    UIImage *navBar = [UIImage imageNamed:@"navbar"];
    //create view for image, append to headerBar
    UIImageView *navBarImageView = [[UIImageView alloc]initWithFrame:headerBar];
    //Add image to view.
    navBarImageView.image = navBar;
    //END HEADER

    //FOOTER
    CGRect tabBar = CGRectMake(0, 523, 320, 45);
    UIView *tabBarView = [[UIView alloc] initWithFrame:tabBar];
    
    UIImage *tabBarImage = [UIImage imageNamed:@"tabbar"];
    UIImageView *tabBarImageView = [[UIImageView alloc] initWithFrame:tabBar];
    tabBarImageView.image = tabBarImage;
    //END FOOTER
    
    
    
    
    [self.view addSubview:headerView];
    [self.view addSubview:navBarImageView];
    
    [self.view addSubview:tabBarView];
    [self.view addSubview:tabBarImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
