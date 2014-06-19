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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onHeadlinesPan:(UIPanGestureRecognizer *)sender {
    
//    CGFloat panCoords = [sender ]
    
    CGPoint panPosition = [sender locationInView:self.view];
    
    CGPoint panVelocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"panStarted");
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"viewdidPan %f %f", panPosition.x, panPosition.y);
        NSLog(@"vel %f", panVelocity.y);
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:.3 initialSpringVelocity:15 options:0 animations:^{
            self.headlinesView.center = CGPointMake(self.headlinesView.center.x, panPosition.y);
        } completion:^(BOOL finished) {
            nil;
        }];
        
        
    };
    
}
@end
