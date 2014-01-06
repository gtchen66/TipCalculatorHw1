//
//  TipViewController.m
//  TipCalculatorHw1
//
//  Created by George Chen on 1/5/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipViewController

// will contain the tip percentage (value 0-50).
NSMutableArray * _myTipValues;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    
    // for settings
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
   
    // default values
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:10 forKey:@"left_percent"];
    [defaults setInteger:15 forKey:@"mid_percent"];
    [defaults setInteger:20 forKey:@"right_percent"];
    
    _myTipValues = [[NSMutableArray alloc] init];
    [_myTipValues addObject:@(10)];
    [_myTipValues addObject:@(15)];
    [_myTipValues addObject:@(20)];
    
//    NSLog(@"view did load");
//    NSLog(@"there are %d elements", [_myTipValues count]);

}

// additional views:
- (void) viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int leftPercent  = [defaults integerForKey:@"left_percent"];
    int midPercent   = [defaults integerForKey:@"mid_percent"];
    int rightPercent = [defaults integerForKey:@"right_percent"];
 
//    NSLog(@"left was set to %@", [_tipValues objectAtIndex:0]);

    // update things here.
    [_myTipValues replaceObjectAtIndex:0 withObject:@(leftPercent)];
    [_myTipValues replaceObjectAtIndex:1 withObject:@(midPercent)];
    [_myTipValues replaceObjectAtIndex:2 withObject:@(rightPercent)];

    [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%",leftPercent] forSegmentAtIndex:0];
    [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%",midPercent] forSegmentAtIndex:1];
    [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%",rightPercent] forSegmentAtIndex:2];
    
//    NSLog(@"now set left to %@", [_myTipValues objectAtIndex:0]);
//    NSLog(@"left percent is %d",leftPercent);
    
    [self updateValues];
}

//- (void) viewDidAppear:(BOOL)animated {
//    NSLog(@"view did appear");
//}
//
//- (void) viewWillDisappear:(BOOL)animated {
//    NSLog(@"view will disappear");
//}
//
//- (void) viewDidDisappear:(BOOL)animated {
//    NSLog(@"view did disappear");
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    float tipAmount = billAmount * [_myTipValues[self.tipControl.selectedSegmentIndex] floatValue] * 0.01;
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%0.2f", totalAmount];
}

- (void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    
    
}

@end
