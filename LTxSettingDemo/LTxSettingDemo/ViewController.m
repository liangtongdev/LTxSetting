//
//  ViewController.m
//  LTxSettingDemo
//
//  Created by liangtong on 2018/8/27.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import "ViewController.h"
#import "LTxSettingForSipprFeedbackViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)feedbackAction:(UIButton *)sender {
    LTxSettingForSipprFeedbackViewController* feedbackVC = [[LTxSettingForSipprFeedbackViewController alloc] init];
    
    [self.navigationController pushViewController:feedbackVC animated:YES];
}


@end
