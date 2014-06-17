//
//  LoginViewController.m
//  FacebookLogin
//
//  Created by Joey Hiller on 6/11/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "LoginViewController.h"
#import "FeedscreenViewController.h"
#import "MoreViewController.h"


@interface LoginViewController ()
// Touch gesture controller
- (IBAction)onTap:(id)sender;

// Text fields
- (IBAction)onUsernameEntered:(id)sender;
- (IBAction)onPasswordEntered:(id)sender;

// Buttons
- (IBAction)onLoginButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

// Keyboard stuff
@property (weak, nonatomic) IBOutlet UIView *loginAreaView;
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

// Functions
- (void)validatePassword;

// Spinny Loader
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;

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
    self.loginButton.enabled = false;
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
    // Because animations can be so pretty!
    [UIView animateWithDuration:0.3 animations:^{self.loginActivityIndicator.alpha = 1.0;}];
    
    // Toggle on the indicator
    [self.loginActivityIndicator startAnimating];
    
    // Set button to selected state
    UIButton *button = (UIButton*) self.loginButton;
    button.selected = !button.selected;
    
    // Fire the validatePassword function with delay
    [self performSelector:@selector(validatePassword) withObject:nil afterDelay:2];
}

- (void)validatePassword {
    //if ([self.passwordTextField.text isEqualToString:@"password"]) {
    if(true){ //for testing
        NSLog(@"Correct Password!");
        // define view controller
        FeedscreenViewController *feedScreenController = [[FeedscreenViewController alloc] init];
        MoreViewController *moreViewController = [[MoreViewController alloc] init];
        
        // Create Nav Controller
        UINavigationController *navController =[[UINavigationController alloc] initWithRootViewController:feedScreenController];
        
        // Initialize the tabbar controller
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        
        //List out the views for the controller
        tabBarController.viewControllers = @[feedScreenController, moreViewController];
        
        // Titles for Nav Bar
        feedScreenController.tabBarItem.title = @"News Feed";
        moreViewController.tabBarItem.title = @"More";
        // firstNavigationController.tabBarItem.image = [UIImage imageNamed:@"House"];

        // define transition
        navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        // do the new view
        [self presentViewController:tabBarController animated:YES completion:nil];
    }
    else {
        // reset the animation
        [self.loginActivityIndicator stopAnimating];
        // reset the button
        self.loginButton.selected = false;
        // set up the alert
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"Try again, sucka!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        // fire the alert
        [alertView show];
    }
}
// Check username field against username field
- (IBAction)onUsernameEntered:(id)sender {
    if (self.passwordTextField.hasText) {
        self.loginButton.enabled = true;
    }
    else {
        self.loginButton.enabled = false;
    }
}
// Check password field against username field
- (IBAction)onPasswordEntered:(id)sender {
    if (self.usernameTextField.hasText) {
        self.loginButton.enabled = true;
    }
    else {
        self.loginButton.enabled = false;
    }
    
}
@end
