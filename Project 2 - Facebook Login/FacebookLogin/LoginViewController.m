//
//  LoginViewController.m
//  FacebookLogin
//
//  Created by Joey Hiller on 6/11/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "LoginViewController.h"
#import "FeedscreenViewController.h"


@interface LoginViewController ()
// Touch gesture controller
- (IBAction)onTap:(id)sender;

// Buttons
- (IBAction)onUsernameEntered:(id)sender;
- (IBAction)onLoginButton:(id)sender;

// Keyboard stuff
@property (weak, nonatomic) IBOutlet UIView *loginAreaView;
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
        
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

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginAreaView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.loginAreaView.frame.size.height, self.loginAreaView.frame.size.width, self.loginAreaView.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    // CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    // NSLog(@"Down - Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginAreaView.frame = CGRectMake(0,  // X-axis
                           // I feel like this shouldn't be hard-coded, but it works...
                           0, // Y-axis
                           self.loginAreaView.frame.size.width,
                           self.loginAreaView.frame.size.height);
                     }
                     completion:nil];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onLoginButton:(id)sender {
    NSLog(@"'Log In' pressed");
    // define view controller
    FeedscreenViewController *vc = [[FeedscreenViewController alloc] init];
    // define transition
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    // do the new view
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)onUsernameEntered:(id)sender {
}
@end
