//
//  HomeViewController.m
//  TumblrApp
//
//  Created by Joey Hiller on 7/4/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *homeSpokesImage;
- (IBAction)onLogInButton:(UIButton *)sender;

@end

@implementation HomeViewController

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
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        self.homeSpokesImage.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogInButton:(UIButton *)sender {
}
@end
