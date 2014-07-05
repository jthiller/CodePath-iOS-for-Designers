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
#import "WriteViewController.h"
#import "ProfileViewController.h"
#import "FeedViewController.h"

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

@property (nonatomic, strong) HomeViewController    *homeViewController;
@property (nonatomic, strong) SearchViewController  *searchViewController;
@property (nonatomic, strong) WriteViewController   *writeViewController;
@property (nonatomic, strong) ProfileViewController *profileViewController;
@property (nonatomic, strong) FeedViewController    *feedViewController;

@property (nonatomic, weak) UIView *previousView;

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
    self.footerContainerView.backgroundColor = [UIColor
                                                colorWithRed: 51.0/255.0
                                                green:        66.0/255.0
                                                blue:         86.0/255.0
                                                alpha:        1.0
                                                ];

    // Keep view content within bounds
//    self.ContainerView.clipsToBounds = YES;
    
    //Init the additional views
    self.homeViewController     = [[HomeViewController alloc] init];
    self.searchViewController   = [[SearchViewController alloc] init];
    self.writeViewController    = [[WriteViewController alloc] init];
    self.profileViewController  = [[ProfileViewController alloc] init];
    self.feedViewController     = [[FeedViewController alloc] init];
    
    [self onHomeButton:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onHomeButton:(UIButton *)sender {
    [self animateInViewController:self.homeViewController.view];
}

- (IBAction)onSearchButton:(UIButton *)sender {
    [self animateInViewController:self.searchViewController.view];
}

- (IBAction)onWriteButton:(UIButton *)sender {
    [self animateInViewController:self.writeViewController.view];
}

- (IBAction)onProfileButton:(UIButton *)sender {
    [self animateInViewController:self.profileViewController.view];
}

- (IBAction)onFeedButton:(UIButton *)sender {
    [self animateInViewController:self.feedViewController.view];
}

- (void)animateInViewController:(UIView *)activeView {
    if (activeView != self.previousView) {
        activeView.frame = CGRectMake(-320, 0, self.ContainerView.frame.size.width, self.ContainerView.frame.size.height);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            activeView.frame = self.ContainerView.frame;
        } completion:nil];
        [self.ContainerView addSubview:activeView];
        activeView.frame = self.ContainerView.frame;

        self.previousView = activeView;
    }
    
}

@end
