//
//  ViewController.m
//  GCD_LCM
//
//  Created by Master on 2014/01/18.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController {
    IBOutlet UISegmentedControl *segment;
    IBOutlet UITextField *leftTextField;
    IBOutlet UITextField *rightTextField;
    IBOutlet UILabel *segmentLabel;
    IBOutlet UILabel *resultLabel;
    
    int leftNumber;
    int rightNumber;
    int resultNumber;
}

#pragma mark - View Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// init numbers
    leftNumber = 0;
    rightNumber = 0;
    resultNumber = 0;
    
    // init TextField & Label
    leftTextField.placeholder = [NSString stringWithFormat:@"%d", leftNumber];
    rightTextField.placeholder = [NSString stringWithFormat:@"%d", rightNumber];
    
    leftTextField.tag = 0;
    rightTextField.tag = 1;
    
    resultLabel.text = [NSString stringWithFormat:@"%d", resultNumber];
    
    segment.selectedSegmentIndex = 0;
    if (segment.selectedSegmentIndex == 0) {
        segmentLabel.text = @"GCD";
    }else{
        segmentLabel.text = @"LCM";
    }
    
    // TextFiled delegate
    leftTextField.delegate = self;
    rightTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - Private
- (IBAction)segmentChange:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:// -- GCD
            segmentLabel.text = @"GCD";
            break;
        case 1:// -- LCM
            segmentLabel.text = @"LCM";
        default:
            break;
    }
}


- (IBAction)showResult:(id)sender{
    leftNumber = [leftTextField.text intValue];
    rightNumber = [rightTextField.text intValue];
    
    if ([segmentLabel.text isEqualToString:@"GCD"]) {
        // calculate GCD
        resultNumber = [self calculateGCD];
        resultLabel.text = [NSString stringWithFormat:@"%d", resultNumber];
        
    }else if ([segmentLabel.text isEqualToString:@"LCM"]){
        // calculate LCM
        resultNumber = [self calculateGCD];
        int lcm = [self calculateLCM];
        resultLabel.text = [NSString stringWithFormat:@"%d", lcm];
    }
    
}


/* -- 最大公約数の計算アルゴリズム(ユークリッド互除法) -- */
// -- ①大きい方の数を小さい数で割る(どっちでもOK)
// -- ②その余りが0だったら「割る数」だった小さい数が最大公約数
// -- ③余りが0ではなかった場合、今出てきた余りで小さい数のほうを割る
// -- ④それを余りが0になるまで繰り返す
- (int)calculateGCD{

    leftNumber = [leftTextField.text intValue];
    rightNumber = [rightTextField.text intValue];
    
    int a = leftNumber;
    int b = rightNumber;
    int number;
    
    while (b != 0) {
        number = a % b;
        a = b;
        b = number;
    }
    
    return a;
}

/* -- 最小公倍数の計算アルゴリズム -- */
// -- 数A × 数B ÷ 最大公約数
- (int)calculateLCM{
    
    leftNumber = [leftTextField.text intValue];
    rightNumber = [rightTextField.text intValue];
    
    int a = leftNumber;
    int b = rightNumber;
    int lcm;
    
    lcm = a * b / resultNumber;
    
    return lcm;
}

@end
