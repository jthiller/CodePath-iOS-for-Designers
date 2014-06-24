//
//  PaperViewController.m
//  Paper Animation
//
//  Created by Joey Hiller on 6/18/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "PaperViewController.h"

@interface PaperViewController ()
@property (strong, nonatomic) IBOutlet UIView *headlinesView;
- (IBAction)onHeadlinesPan:(UIPanGestureRecognizer *)sender;

// Set universal vars
@property (assign, nonatomic) CGPoint headlinesTouchOffset;

@end

@implementation PaperViewController

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
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onHeadlinesPan:(UIPanGestureRecognizer *)sender {
    
    CGPoint panPosition = [sender locationInView:self.view];
    
    CGPoint panVelocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.headlinesTouchOffset = CGPointMake(panPosition.x - self.headlinesView.center.x, panPosition.y - self.headlinesView.center.y);
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"viewdidPan %f %f", panPosition.x, panPosition.y);
//        NSLog(@"vel %f", panVelocity.y);
        
        self.headlinesView.center = CGPointMake(self.headlinesView.center.x, (panPosition.y - self.headlinesTouchOffset.y));

        
//        if ((panPosition.y - self.headlinesTouchOffset.y) >= self.view.frame.size.height-50) {
//            self.headlinesView.center = CGPointMake(self.headlinesView.center.x, (panPosition.y - self.headlinesTouchOffset.y));
//            NSLog(@"viewdidPanScaled %f", panPosition.y - self.headlinesTouchOffset.y);
//            NSLog(@"%f",self.view.frame.size.height-50);
//        }
//        else if ((panPosition.y - self.headlinesTouchOffset.y) < self.view.frame.size.height-50){
//            self.headlinesView.center = CGPointMake(self.headlinesView.center.x, (panPosition.y - self.headlinesTouchOffset.y));
//            NSLog(@"viewdidPan %f", panPosition.y - self.headlinesTouchOffset.y);
//
//        }
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Gesture has ended with velocity %f", panVelocity.y);
        // Swipe down, continue to bottom
        if (panVelocity.y >= 500) {
            [UIView animateWithDuration:(panVelocity.y/10000) animations:^{
                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, 800);
            } completion:nil];
        }
        // Swipe up, Return to center
        else if (panVelocity.y <= -500) {
            [UIView animateWithDuration:(panVelocity.y/-10000) animations:^{
                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
            } completion:nil];
        }
        
        else if (self.headlinesView.center.y <= self.view.center.y+200) {
            [UIView animateWithDuration:(.25) animations:^{
                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
            } completion:nil];
        }
        else if (self.headlinesView.center.y > self.view.center.y+200) {
            [UIView animateWithDuration:(.25) animations:^{
                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, 800);
            } completion:nil];
        }
        
        // From center, return to center if moved upward.
        else if (self.headlinesView.center.y < self.view.center.y) {
            [UIView animateWithDuration:abs((self.headlinesView.center.y - self.view.center.y))/300.0
                                  delay:0
                 usingSpringWithDamping:.5
                  initialSpringVelocity:3
                                options:0
                             animations:^{
                                 self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
                             } completion:nil
             ];
        }
//        //If the top of the headlines view is
//        else if ((self.headlinesView.center.y-(self.headlinesView.frame.size.height/2)) > self.view.frame.origin.y + 100 ) {
//            [UIView animateWithDuration:(.5) animations:^{
//                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
//                NSLog(@"otheWAY");
//            } completion:nil];
//        }
        
        
//        if (self.headlinesView.center.y < self.view.center.y) {
//            [UIView animateWithDuration:.5
//                                  delay:0
//                 usingSpringWithDamping:.15
//                  initialSpringVelocity:1
//                                options:0
//                             animations:^{
//                                 self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
//                             } completion:nil
//             ];
////            [UIView animateWithDuration:(.25) animations:^{
////                self.headlinesView.center = CGPointMake(self.headlinesView.center.x, self.view.center.y);
////            } completion:nil];
//        }
    }
    
}
@end
