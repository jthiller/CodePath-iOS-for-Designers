//
//  TipViewController.m
//  Tip Calculator
//
//  Created by Joey Hiller on 5/27/14.
//  Copyright (c) 2014 Joey Hiller. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UILabel *billTextFieldLabel;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIStepper *splitAdd;
@property (weak, nonatomic) IBOutlet UILabel *splitCount;
@property (weak, nonatomic) IBOutlet UILabel *splitTotalLabel;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

-(void)updateValues {
    //Get the value from the tip segmented control
    float billAmount = [self.billTextField.text floatValue];
    
    //Get the count from the stepper
    int peopleCount = [self.splitAdd value];

    //Assign values to the tip segments
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    //Calculate tip from selected tip percentage
    float tipAmount = billAmount * [tipValues [self.tipControl.selectedSegmentIndex] floatValue];
    //Calculate total with tip
    float totalAmount = tipAmount + billAmount;
    //Calculate total per person
    float splitAmount = totalAmount / peopleCount;
    
    //Write the tip portion
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    //Write the sum
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    //Write the split sum
    self.splitTotalLabel.text = [NSString stringWithFormat:@"$%0.2f", splitAmount];
    //Write the number of people, w/conditionally pluralized label
    if (peopleCount == 1) {
        self.splitCount.text = [NSString stringWithFormat:@"%i way",peopleCount];
    }
    else {
        self.splitCount.text = [NSString stringWithFormat:@"%i ways",peopleCount];
    }
}

@end
