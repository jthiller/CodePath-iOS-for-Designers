//
//  ViewController.m
//  Week_4_HW
//
//  Created by Joey Hiller on 6/29/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)onDrawerPan:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIView *drawerView;
- (IBAction)onBearPan:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bearView;
@property (weak, nonatomic) IBOutlet UIScrollView *drawerScrollView;

@property (nonatomic) UIImageView *duplicateView;

@property (nonatomic) UIPanGestureRecognizer *stickerPanGesture;
@property (nonatomic) UIPinchGestureRecognizer *stickerPinchGesture;

- (void)stickerDidPan:(UIPanGestureRecognizer *)panGesture;
- (void)stickerDidScale:(UIPinchGestureRecognizer *)pinchGesture;


@end

@implementation ViewController

float startingPanYPosition;
float distancePanned;
float currentDrawerViewYPosition;

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
    
    self.stickerPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(stickerDidPan:)];
    self.stickerPinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(stickerDidScale:)];
}

-(void)viewDidLayoutSubviews {
    self.drawerScrollView.contentSize = self.drawerView.frame.size;
    //[self.drawerScrollView setScrollEnabled:true];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDrawerPan:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    CGRect frame = self.drawerView.frame;
    
    
    //begin panning stuffs
    if (sender.state == UIGestureRecognizerStateBegan) {
        float startingHeight = self.drawerView.frame.origin.y;
        startingPanYPosition = point.y;
        currentDrawerViewYPosition = startingHeight;
        
    }
    
    //panning continues stuffs
    else if (sender.state == UIGestureRecognizerStateChanged) {
        
        distancePanned = point.y - startingPanYPosition;
        frame.origin.y = currentDrawerViewYPosition + distancePanned;
        
        if (frame.origin.y > 550) {
            frame.origin.y = 550;
        }
        
        if (frame.origin.y < 0) {
            frame.origin.y = frame.origin.y/5;
        }
        
        self.drawerView.frame = frame;
        
    }
    
    //panning ends stuffs
    else if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (velocity.y >= 0) {
            frame.origin.y = 501;
            [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:0 options:0
                             animations:^{
                                 self.drawerView.frame = frame;
                             } completion:nil];
        }
        
        else if (velocity.y <= 0) {
            frame.origin.y = 0;
            [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:0 options:0
                             animations:^{
                                 self.drawerView.frame = frame;
                             } completion:nil];
            
        }
        
    }
    
    
}
- (IBAction)onBearPan:(UIPanGestureRecognizer *)sender {
//    CGPoint location = [sender locationInView:self.view];
    CGPoint translation = [sender translationInView:self.view];

    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //newView = [sender.view copy];
        //[self.view addSubview:newView];
        self.duplicateView = [[UIImageView alloc] init];
        self.duplicateView.image = [(UIImageView *)sender.view image];
        CGRect frame = sender.view.frame;
        frame.origin.y += self.drawerScrollView.frame.origin.y;
        self.duplicateView.frame = frame;
        
        [self.view addSubview:self.duplicateView];
        [self.duplicateView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(stickerDidPan:)]];
        [self.duplicateView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(stickerDidScale:)]];
        [self.duplicateView setUserInteractionEnabled:YES];
    }
    
    else if(sender.state == UIGestureRecognizerStateChanged) {
        //NSLog(@"Location (%f,%f) Translation (%f, %f)", location.x, location.y, translation.x, translation.y);
        
        self.duplicateView.center = CGPointMake(self.duplicateView.center.x + translation.x, self.duplicateView.center.y + translation.y);
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        //UIImageView *view;
        
    }
    
    
}

- (void)stickerDidPan:(UIPanGestureRecognizer *)panGesture {
    NSLog(@"panning sticker");
    CGPoint translation = [panGesture translationInView:self.view];
    
   if(panGesture.state == UIGestureRecognizerStateChanged) {
        //NSLog(@"Location (%f,%f) Translation (%f, %f)", location.x, location.y, translation.x, translation.y);
        
        panGesture.view.center = CGPointMake(panGesture.view.center.x + translation.x, panGesture.view.center.y + translation.y);
        [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
        
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        //UIImageView *view;
        
    }
    else if (panGesture.state == UIGestureRecognizerStateFailed) {
        NSLog(@"FAIL");
    }
}

- (void) stickerDidScale:(UIPinchGestureRecognizer *)pinchGesture {
    NSLog(@"PinchHappened");
    if(pinchGesture.state == UIGestureRecognizerStateChanged) {
        pinchGesture.view.transform = CGAffineTransformMakeScale(pinchGesture.scale, pinchGesture.scale);
    }
}

@end
