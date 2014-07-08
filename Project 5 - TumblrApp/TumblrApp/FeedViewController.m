//
//  FeedViewController.m
//  TumblrApp
//
//  Created by Joey Hiller on 7/4/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *ActivityScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *loadingImage;
@property (strong, atomic) NSArray* loadingImages;
@end

@implementation FeedViewController

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
    
    self.ActivityScrollView.alpha = 0;
    
    self.loadingImages = [NSArray arrayWithObjects:
                        [UIImage imageNamed:@"loading-1"],
                        [UIImage imageNamed:@"loading-2"],
                        [UIImage imageNamed:@"loading-3"],
                        nil];
    
    self.loadingImage.animationImages = self.loadingImages;
    self.loadingImage.animationDuration = .5;
    self.loadingImage.animationRepeatCount = 0;
    [self.loadingImage startAnimating];
    
    [UIView animateWithDuration:.2 delay:1 options:0 animations:^{
        self.ActivityScrollView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.loadingImage stopAnimating];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
