//
//  SearchViewController.m
//  TumblrApp
//
//  Created by Joey Hiller on 7/4/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *searchScrollView;
@property (strong, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
- (IBAction)onSearchPageTap:(UITapGestureRecognizer *)sender;

@end

@implementation SearchViewController

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
    
    self.searchScrollView.contentSize = self.scrollContentView.frame.size;
    self.view.backgroundColor = [UIColor colorWithRed:51.0/255.0
                green:70.0/255.0
                blue:93.0/255.0
                alpha:1
        ];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSearchPageTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
@end
