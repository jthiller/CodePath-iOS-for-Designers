//
//  ViewController.m
//  Week_4_HW
//
//  Created by Joey Hiller on 6/29/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *drawerView;
- (IBAction)onBearPan:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bearView;
@property (weak, nonatomic) IBOutlet UIScrollView *drawerScrollView;
- (IBAction)onTrayPan:(UIPanGestureRecognizer *)sender;

@property (nonatomic) UIImageView *duplicateView;

@property (nonatomic) UIPanGestureRecognizer *stickerPanGesture;
@property (nonatomic) UIPinchGestureRecognizer *stickerPinchGesture;
@property (nonatomic) UIRotationGestureRecognizer *stickerRotationGesture;

- (void)stickerDidPan:(UIPanGestureRecognizer *)panGesture;
- (void)stickerDidScale:(UIPinchGestureRecognizer *)pinchGesture;
- (void)stickerDidRotate:(UIRotationGestureRecognizer *)rotationGesture;

@property (assign, nonatomic) float iconRotation;
@property (assign, nonatomic) float iconSize;
@property (assign, nonatomic) CGPoint trayLocation;

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
    self.stickerRotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(stickerDidRotate:)];
    
    // Initialize the angle/scale vars for pinch/rotate
    self.iconRotation = 0.0;
    self.iconSize = 2.0;
    
    self.drawerScrollView.center = CGPointMake(self.drawerScrollView.center.x, 580);
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"testing");
    if (otherGestureRecognizer == self.drawerScrollView.panGestureRecognizer) {
        return YES;
    }
    return NO;

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

- (IBAction)onBearPan:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //Create new image view
        self.duplicateView = [[UIImageView alloc] init];
        // Put the sent image into the new image view
        self.duplicateView.image = [(UIImageView *)sender.view image];
        // Don't stretch my cats!
        [self.duplicateView setContentMode:UIViewContentModeScaleAspectFit];
        // Give the new image view a home
        CGRect frame = sender.view.frame;
        // Position the new image view's frame to the offset of the drawer view
        frame.origin.y += self.drawerScrollView.frame.origin.y;
        // Set the new frame to use the sender's frame
        self.duplicateView.frame = frame;
        // Add as a subview
        [self.view addSubview:self.duplicateView];
        // Set to interaction:enabled, BECAUSE OTHERWISE THEY AREN'T!! >:(
        [self.duplicateView setUserInteractionEnabled:YES];
        //Increase the scale so pinching can happen
        self.duplicateView.transform = CGAffineTransformMakeScale(2, 2);
        
        //Add gesture recognizers
        [self.duplicateView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(stickerDidPan:)]];
        [self.duplicateView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(stickerDidScale:)]];
        [self.duplicateView addGestureRecognizer:[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(stickerDidRotate:)]];
    }
    else if(sender.state == UIGestureRecognizerStateChanged) {
        self.duplicateView.center = CGPointMake(self.duplicateView.center.x + translation.x, self.duplicateView.center.y + translation.y);
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [self.view bringSubviewToFront:self.drawerScrollView];
    }
    
    
}
// Gesture Recognizer Methods
- (void)stickerDidPan:(UIPanGestureRecognizer *)panGesture {
    CGPoint translation = [panGesture translationInView:self.view];
    if(panGesture.state == UIGestureRecognizerStateChanged) {
        panGesture.view.center = CGPointMake(panGesture.view.center.x + translation.x, panGesture.view.center.y + translation.y);
        [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

- (void) stickerDidScale:(UIPinchGestureRecognizer *)pinchGesture {
    self.iconSize = (pinchGesture.scale * self.iconSize)/1.5+1.0;
    if(pinchGesture.state == UIGestureRecognizerStateChanged) {
        CGAffineTransform myTransform = CGAffineTransformMakeScale(self.iconSize,self.iconSize);
        myTransform = CGAffineTransformRotate(myTransform,self.iconRotation);
        pinchGesture.view.transform = myTransform;
    }
}

-(void) stickerDidRotate:(UIRotationGestureRecognizer *)rotationGesture {
    self.iconRotation = (rotationGesture.rotation/180.0)*M_PI + self.iconRotation;
    if(rotationGesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"rotationHappened %f", self.iconRotation);
        CGAffineTransform myTransform = CGAffineTransformMakeRotation(self.iconRotation);
        myTransform = CGAffineTransformScale(myTransform, self.iconSize, self.iconSize);
        rotationGesture.view.transform = myTransform;
    }
}

- (IBAction)onTrayPan:(UIPanGestureRecognizer *)sender {
//    CGPoint touchPoint = [sender locationInView:self.view];
//    CGPoint trayLocation = [sender locationInView:self.view];
    CGPoint trayLocation =[sender locationInView:self.view];

    if (sender.state == UIGestureRecognizerStateBegan) {
//        self.trayLocation = CGPointMake(touchPoint.x - self.drawerScrollView.center.x, touchPoint.y - self.drawerScrollView.center.y);
        NSLog(@"TrayLocation: %f", trayLocation.y);
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        if (trayLocation.y >= (self.view.window.frame.size.height - self.drawerScrollView.frame.size.height/2)) {
            self.drawerScrollView.center = CGPointMake(self.drawerScrollView.center.x, trayLocation.y);
        }
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        if (trayLocation.y <= (self.view.window.frame.size.height - self.drawerScrollView.frame.size.height*(2/3))) {
            NSLog(@"Done");
            [self.drawerScrollView removeGestureRecognizer:[self.drawerScrollView.gestureRecognizers objectAtIndex:0]];
            [UIView animateWithDuration:abs((self.drawerScrollView.center.y - self.view.center.y))/300.0
                                  delay:0
                 usingSpringWithDamping:.5
                  initialSpringVelocity:3
                                options:0
                             animations:^{
                                 self.drawerScrollView.center = CGPointMake(self.drawerScrollView.center.x, (self.view.window.frame.size.height - self.drawerScrollView.frame.size.height/2));
                             } completion:nil
             ];

        }
        else if (trayLocation.y >= (self.view.window.frame.size.height - self.drawerScrollView.frame.size.height*(1/3))) {
            NSLog(@"NotDone");
        }
    }
}
@end
