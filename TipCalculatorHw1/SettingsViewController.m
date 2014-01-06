//
//  SettingsViewController.m
//  TipCalculatorHw1
//
//  Created by George Chen on 1/6/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *leftTipAmount;
@property (weak, nonatomic) IBOutlet UILabel *midTipAmount;
@property (weak, nonatomic) IBOutlet UILabel *rightTipAmount;

@property (weak, nonatomic) IBOutlet UISlider *leftSlider;
@property (weak, nonatomic) IBOutlet UISlider *midSlider;
@property (weak, nonatomic) IBOutlet UISlider *rightSlider;

@property (weak, nonatomic) IBOutlet UIStepper *leftStepper;
@property (weak, nonatomic) IBOutlet UIStepper *midStepper;
@property (weak, nonatomic) IBOutlet UIStepper *rightStepper;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;

- (IBAction)leftSliderChange:(id)sender;
- (IBAction)leftStepperChange:(id)sender;
- (IBAction)midSliderChange:(id)sender;
- (IBAction)midStepperChange:(id)sender;
- (IBAction)rightSliderChange:(id)sender;
- (IBAction)rightStepperChange:(id)sender;

- (IBAction)resetButtonPressed:(id)sender;
- (void) updateTipPercent;
@end

@implementation SettingsViewController

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
    // all values are reset.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int leftPercent  = [defaults integerForKey:@"left_percent"];
    int midPercent   = [defaults integerForKey:@"mid_percent"];
    int rightPercent = [defaults integerForKey:@"right_percent"];

    self.leftSlider.value = leftPercent;
    self.leftStepper.value = leftPercent;
    self.midSlider.value = midPercent;
    self.midStepper.value = midPercent;
    self.rightSlider.value = rightPercent;
    self.rightStepper.value = rightPercent;

    self.leftTipAmount.text = [NSString stringWithFormat:@"%d", leftPercent];
    self.midTipAmount.text = [NSString stringWithFormat:@"%d", midPercent];
    self.rightTipAmount.text = [NSString stringWithFormat:@"%d", rightPercent];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Slider and Stepper need to update each other.
// Anyway to quantize slider value?
- (IBAction)leftSliderChange:(id)sender {
    self.leftStepper.value = floor(self.leftSlider.value);
    [self updateTipPercent];
}

- (IBAction)leftStepperChange:(id)sender {
//    NSLog(@"leftStepper is %f", self.leftStepper.value);
    // set slider
    self.leftSlider.value = self.leftStepper.value;
    [self updateTipPercent];
}

- (IBAction)midSliderChange:(id)sender {
    self.midStepper.value = floor(self.midSlider.value);
    [self updateTipPercent];
}

- (IBAction)midStepperChange:(id)sender {
    self.midSlider.value = self.midStepper.value;
    [self updateTipPercent];
}

- (IBAction)rightSliderChange:(id)sender {
    self.rightStepper.value = floor(self.rightSlider.value);
    [self updateTipPercent];
}

- (IBAction)rightStepperChange:(id)sender {
    self.rightSlider.value = self.rightStepper.value;
    [self updateTipPercent];
}

- (IBAction)resetButtonPressed:(id)sender {
    self.leftStepper.value = 10;
    self.leftSlider.value = 10;
    self.midStepper.value = 15;
    self.midSlider.value = 15;
    self.rightSlider.value = 20;
    self.rightStepper.value = 20;
//    NSLog(@"reset left to 10");
    
    [self updateTipPercent];
}

- (void) updateTipPercent {
    int leftPercent = floor(self.leftSlider.value);
    int midPercent = floor(self.midSlider.value);
    int rightPercent = floor(self.rightSlider.value);
    
    self.leftTipAmount.text = [NSString stringWithFormat:@"%d", leftPercent];
    self.midTipAmount.text = [NSString stringWithFormat:@"%d", midPercent];
    self.rightTipAmount.text = [NSString stringWithFormat:@"%d", rightPercent];
    
//    NSLog(@"leftPercent is %d", leftPercent);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:leftPercent forKey:@"left_percent"];
    [defaults setInteger:midPercent forKey:@"mid_percent"];
    [defaults setInteger:rightPercent forKey:@"right_percent"];
    
}

@end
