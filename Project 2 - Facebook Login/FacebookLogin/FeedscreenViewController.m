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

@synthesize scrollView;

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
    
    [self.scrollView setScrollEnabled:true];
    [self.scrollView setContentSize:CGSizeMake(320, 500)];
    
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
    NSLog(@"made it");
    [self.loadIndicator stopAnimating];
}

@end
