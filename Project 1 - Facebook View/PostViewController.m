//
//  PostViewController.m
//  CodePath-Week1
//
//  Created by Joey Hiller on 6/5/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UIView *postView;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
- (IBAction)onLikeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation PostViewController

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
    NSLog(@"View did load!");
    
    //HEADER
    //Create frame for header
    CGRect headerBar = CGRectMake(0, 0, 320, 65);
    //create view for header
    UIView *headerView = [[UIView alloc] initWithFrame:headerBar];

    //declare image
    UIImage *navBar = [UIImage imageNamed:@"navbar"];
    //create view for image, append to headerBar
    UIImageView *navBarImageView = [[UIImageView alloc]initWithFrame:headerBar];
    //Add image to view.
    navBarImageView.image = navBar;
    //END HEADER
    
    
    //CONTENT
//    self.postView.backgroundColor = [UIColor whiteColor];
    self.postView.layer.cornerRadius = 2;
    self.postView.layer.shadowColor = [UIColor colorWithRed:5.0/255.0 green:7.0/255.0 blue:20.0/255.0 alpha:1].CGColor;
    self.postView.layer.shadowRadius = 2;
    self.postView.layer.shadowOffset = CGSizeMake(0, 0);
    self.postView.layer.shadowOpacity = .35;
    
    self.postImage.layer.shadowColor = [UIColor colorWithRed:5.0/255.0 green:7.0/255.0 blue:20.0/255.0 alpha:1].CGColor;
    self.postImage.layer.shadowRadius = 1;
    self.postImage.layer.shadowOffset = CGSizeMake(0, 1);
    self.postImage.layer.shadowOpacity = .35;
    

    
    //END CONTENT
    
    

    //FOOTER
    CGRect tabBar = CGRectMake(0, 523, 320, 45);
    UIView *tabBarView = [[UIView alloc] initWithFrame:tabBar];
    
    UIImage *tabBarImage = [UIImage imageNamed:@"tabbar"];
    UIImageView *tabBarImageView = [[UIImageView alloc] initWithFrame:tabBar];
    tabBarImageView.image = tabBarImage;
    //END FOOTER
    
    
    [self.view addSubview:headerView];
    [self.view addSubview:navBarImageView];
    
    [self.view addSubview:tabBarView];
    [self.view addSubview:tabBarImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLikeButton:(id)sender {
    if(self.likeButton.selected)
        [self.likeButton setSelected:NO];
    else
        [self.likeButton setSelected:YES];
}
@end
