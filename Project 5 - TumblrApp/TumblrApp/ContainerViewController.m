//
//  ContainerViewController.m
//  TumblrApp
//
//  Created by Joey Hiller on 7/4/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "ContainerViewController.h"
// Import Subviews
#import "HomeViewController.h"
#import "SearchViewController.h"

@interface ContainerViewController ()
// App Container View
@property (strong, nonatomic) IBOutlet UIView *ContainerView;

//Footer Container and Buttons
@property (strong, nonatomic) IBOutlet UIView *footerContainerView;
- (IBAction)onHomeButton:   (UIButton *)sender;
- (IBAction)onSearchButton: (UIButton *)sender;
- (IBAction)onWriteButton:  (UIButton *)sender;
- (IBAction)onProfileButton:(UIButton *)sender;
- (IBAction)onFeedButton:   (UIButton *)sender;

@end

@implementation ContainerViewController

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
    
    // Styling the footer view
    self.footerContainerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:66.0/255.0 blue:86.0/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onHomeButton:(UIButton *)sender {
//    self.ContainerView. = [[HomeViewController alloc] init];
}

- (IBAction)onSearchButton:(UIButton *)sender {
}

- (IBAction)onWriteButton:(UIButton *)sender {
}

- (IBAction)onProfileButton:(UIButton *)sender {
}

- (IBAction)onFeedButton:(UIButton *)sender {
}

@end
