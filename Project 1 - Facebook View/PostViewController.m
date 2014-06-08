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
    
    
    //CONTENT
    CGRect postFrame = CGRectMake(10, 75, 300, 600);
    UIView *postView = [[UIView alloc] initWithFrame:postFrame];
    
    postView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.1];
    postView.layer.cornerRadius = 2;
    postView.layer.shadowRadius = 1;
    postView.layer.shadowColor = [UIColor colorWithRed:5.0/255.0 green:7.0/255.0 blue:20.0/255.0 alpha:1].CGColor;
    postView.layer.shadowOffset = CGSizeMake(0, 0);
    postView.layer.shadowOpacity = .45;

    CGRect userIconFrame = CGRectMake(15, 13, 40, 40);
//    UIImage *postIcon = [UIImage imageNamed:@"her_poster"];
    UIView *postIconView = [[UIView alloc] initWithFrame:userIconFrame];
    postIconView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];

    [postView addSubview:postIconView];

    
    //END CONTENT
    
    

    //FOOTER
    CGRect tabBar = CGRectMake(0, 523, 320, 45);
    UIView *tabBarView = [[UIView alloc] initWithFrame:tabBar];
    
    UIImage *tabBarImage = [UIImage imageNamed:@"tabbar"];
    UIImageView *tabBarImageView = [[UIImageView alloc] initWithFrame:tabBar];
    tabBarImageView.image = tabBarImage;
    //END FOOTER
    
    
    
    
    [self.view addSubview:headerView];
    [self.view addSubview:navBarImageView];
    
    [self.view addSubview:postView];
    
    [self.view addSubview:tabBarView];
    [self.view addSubview:tabBarImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
