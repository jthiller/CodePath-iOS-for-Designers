//
//  FeedscreenViewController.m
//  FacebookLogin
//
//  Created by Joey Hiller on 6/14/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "FeedscreenViewController.h"

@interface FeedscreenViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageScrollView;

- (void)feedLoad;

@end

@implementation FeedscreenViewController


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

    
    self.navigationItem.title = @"News Feed";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.301 green:0.472 blue:0.666 alpha:1];
    self.navigationController.navigationBar.translucent = false;
    
    UIImage *leftButtonImage = [[UIImage imageNamed:@"leftButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
    

    self.scrollView.hidden = true;
    // Activate the feed after 2 seconds
    [self performSelector:@selector(feedLoad) withObject:nil afterDelay:2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    self.scrollView.contentSize = self.imageScrollView.frame.size;
}

-(void)feedLoad {
    //Kill the load indicator
    [self.loadIndicator stopAnimating];
    
    // Re-enable the feed
    self.scrollView.hidden = false;
    // Fade in the feed
    [UIView animateWithDuration:0.3 animations:^{self.scrollView.alpha = 1.0;}];
}

@end
