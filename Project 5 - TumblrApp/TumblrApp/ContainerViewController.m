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
@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIButton *writeButton;
@property (strong, nonatomic) IBOutlet UIButton *profileButton;
@property (strong, nonatomic) IBOutlet UIButton *feedButton;

//External Views
@property (nonatomic, strong) HomeViewController    *homeViewController;
@property (nonatomic, strong) SearchViewController  *searchViewController;
@property (nonatomic, strong) ProfileViewController *profileViewController;
@property (nonatomic, strong) FeedViewController    *feedViewController;

//Write Menu element outlets
@property (strong, nonatomic) IBOutlet UIView   *writeMenuView;
@property (strong, nonatomic) IBOutlet UIButton *textButton;
@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, nonatomic) IBOutlet UIButton *quoteButton;
@property (strong, nonatomic) IBOutlet UIButton *linkButton;
@property (strong, nonatomic) IBOutlet UIButton *chatButton;
@property (strong, nonatomic) IBOutlet UIButton *videoButton;
- (IBAction)onWriteMenuTap:(UITapGestureRecognizer *)sender;

//Tooltip Stuff
@property (strong, nonatomic) IBOutlet UIView *TooltipView;
@property (nonatomic, assign) BOOL tooltipIsAnimating;

//Variable to monitor the currently presented view
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
    
    // Set Status Bar to white
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Background for master controller
    self.view.backgroundColor = [UIColor
                                colorWithRed: 51.0/255.0
                                green:        66.0/255.0
                                blue:         86.0/255.0
                                alpha:        1.0
                                ];
    
    // Styling the footer view
    self.footerContainerView.backgroundColor = [UIColor
                                                colorWithRed: 51.0/255.0
                                                green:        66.0/255.0
                                                blue:         86.0/255.0
                                                alpha:        1.0
                                                ];
    
    //Init the additional views
    self.homeViewController     = [[HomeViewController alloc] init];
    self.searchViewController   = [[SearchViewController alloc] init];
    self.profileViewController  = [[ProfileViewController alloc] init];
    self.feedViewController     = [[FeedViewController alloc] init];
    
    // Call 'Home Button' on load
    [self onHomeButton:nil];
    
    // Menu is hidden on load
    self.writeMenuView.hidden = YES;
    
    [self animateTooltip];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onHomeButton:(UIButton *)sender {
    [self setActiveViewController:self.homeViewController.view];
    [self setActiveButton:sender];
}

- (IBAction)onSearchButton:(UIButton *)sender {
    [self setActiveViewController:self.searchViewController.view];
    [self setActiveButton:sender];
}

- (IBAction)onWriteButton:(UIButton *)sender {
    // Gets other stuff
    if (self.writeMenuView.hidden == YES) {
        [self buildWriteView];
    }
    else {
        [self closeWriteView];
    }
    [self setActiveButton:sender];
}

- (IBAction)onProfileButton:(UIButton *)sender {
    [self setActiveViewController:self.profileViewController.view];
    [self setActiveButton:sender];
}

- (IBAction)onFeedButton:(UIButton *)sender {
    [self setActiveViewController:self.feedViewController.view];
    [self setActiveButton:sender];
}

// Set Active External View
- (void)setActiveViewController:(UIView *)activeView {
    if (activeView != self.previousView) {
        activeView.frame = self.ContainerView.frame;
        [self.ContainerView addSubview:activeView];
        self.previousView = activeView;
    }
}

- (void)buildWriteView {
    self.writeMenuView.hidden = NO;
    self.writeMenuView.alpha = 0;
    [UIView animateWithDuration:.2
                          delay:0
                        options:0
                     animations:^{
                         self.writeMenuView.alpha = 1;
                     }
                     completion:nil];
    
    // Override the default footer's importance
    [self.view bringSubviewToFront:self.writeMenuView];

    // animate in buttons
    [self animateInPostButton:self.textButton   withDelay:.20];
    [self animateInPostButton:self.photoButton  withDelay:.05];
    [self animateInPostButton:self.quoteButton  withDelay:.10];
    [self animateInPostButton:self.linkButton   withDelay:.30];
    [self animateInPostButton:self.chatButton   withDelay:.25];
    [self animateInPostButton:self.videoButton  withDelay:.35];
}

-(void)closeWriteView {
    //Transition out all of the buttons
    [self animateOutPostButton:self.textButton   withDelay:.20];
    [self animateOutPostButton:self.photoButton  withDelay:.05];
    [self animateOutPostButton:self.quoteButton  withDelay:.10];
    [self animateOutPostButton:self.linkButton   withDelay:.30];
    [self animateOutPostButton:self.chatButton   withDelay:.25];
    [self animateOutPostButton:self.videoButton  withDelay:.35];
    //After all transitions complete, fade out
    [UIView animateWithDuration:.2
                          delay:.35
                        options:0
                     animations:^{
                         self.writeMenuView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         self.writeMenuView.hidden = YES;
                         self.writeButton.selected = NO;
                     }
     ];
}

- (void)animateInPostButton:(UIButton *)button withDelay:(NSTimeInterval)delayTime {
    NSInteger buttonOffset = 400;
    
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y+buttonOffset, button.frame.size.width, button.frame.size.height);
    
    [UIView animateWithDuration:.6
                          delay:delayTime
         usingSpringWithDamping:2
          initialSpringVelocity:20
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                                button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y-buttonOffset, button.frame.size.width, button.frame.size.height);
                                }
                     completion:nil];
}

-(void)animateOutPostButton:(UIButton *)button withDelay:(NSTimeInterval)delayTime {
    NSInteger buttonOffset = 400;

    [UIView animateWithDuration:.6
                          delay:delayTime
         usingSpringWithDamping:2
          initialSpringVelocity:20
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y-buttonOffset, button.frame.size.width, button.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y+buttonOffset, button.frame.size.width, button.frame.size.height);
                     }
     ];
}

// When tapping the presented modal
- (IBAction)onWriteMenuTap:(UITapGestureRecognizer *)sender {
    [self closeWriteView];
}

-(void) setActiveButton:(UIButton *)sender {
    // Clear all
    self.homeButton.selected    = NO;
    self.searchButton.selected  = NO;
    self.writeButton.selected   = NO;
    self.profileButton.selected = NO;
    self.feedButton.selected    = NO;
    // Except the active one
    sender.selected = YES;
    
    
    // Check the state for the tooltip
    if (sender == self.searchButton) {
        [UIView animateWithDuration:.25
                         animations:^{
                             self.TooltipView.alpha = 0;
                             self.TooltipView.transform = CGAffineTransformMakeTranslation(0, 10);
                         }
                         completion:^(BOOL finished) {
                             self.TooltipView.hidden = YES;
                             self.tooltipIsAnimating = NO;
                         }
         ];
    }
    else if(self.tooltipIsAnimating == NO){
        self.TooltipView.hidden = NO;
        [UIView animateWithDuration:.5
                              delay:.5
                            options:0
                         animations:^{
                            self.TooltipView.alpha = 1;
                            self.TooltipView.transform = CGAffineTransformMakeTranslation(0, -10);
                         }
                         completion:^(BOOL finished) {
                             [self animateTooltip];
                             self.tooltipIsAnimating = YES;
                         }
        ];
    }
}

-(void) animateTooltip {
    [UIView animateWithDuration:.9 delay:0 options:
     UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAutoreverse animations:^{
        self.TooltipView.transform = CGAffineTransformMakeTranslation(0, 5);
    } completion:nil];
}


// -(void) viewDidLayoutSubviews {
//     [super viewDidLayoutSubviews];
//     if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
//         CGRect frame = self.view.frame;
//         frame.origin.y = 20;
//         frame.size.height = frame.size.height - 20;
//         self.view.frame = frame;
//     }
// }
@end
