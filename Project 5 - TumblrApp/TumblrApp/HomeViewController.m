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
@property (strong, nonatomic) IBOutlet UIImageView *homeScreen;
- (IBAction)onHomeLogIn:(UIButton *)sender;

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
    
    //Set initial state of elements;
    self.homeScreen.alpha = 0;
    self.homeScreen.transform = CGAffineTransformMakeScale(0, 0);
    self.homeSpokesImage.alpha = 0;
    self.homeSpokesImage.transform = CGAffineTransformMakeScale(0, 0);
    
    // Animate in the elements
    [UIView animateWithDuration:.8
                          delay:.2
         usingSpringWithDamping:3
          initialSpringVelocity:20
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.homeScreen.alpha = 1;
                         self.homeScreen.transform = CGAffineTransformMakeScale(1, 1);
                     }
                     completion:^(BOOL finished) {
        // Animate in the spokes
        [UIView animateWithDuration:.6
                              delay:0
             usingSpringWithDamping:3
              initialSpringVelocity:20
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.homeSpokesImage.alpha = 1;
                             self.homeSpokesImage.transform = CGAffineTransformMakeScale(1, 1);
                         }
                         completion:^(BOOL finished) {
                             // Rotate the spokes
                             [UIView animateWithDuration:10
                                                   delay:0
                                                 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.homeSpokesImage.transform = CGAffineTransformMakeRotation(3.1415923); //for some reason M_PI doesn't work. It can't be set to positive and always rotates in the wrong direction.
                                              }
                                              completion:nil];
                         }];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onHomeLogIn:(UIButton *)sender {

}

@end
