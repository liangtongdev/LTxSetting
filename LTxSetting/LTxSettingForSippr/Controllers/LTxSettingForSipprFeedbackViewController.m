//
//  LTxSettingForSipprFeedbackViewController.m
//  LTxSetting
//
//  Created by liangtong on 2018/7/25.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxSettingForSipprFeedbackViewController.h"
#import "LTxSettingForSipprViewModel.h"
#import <LTxPopup/LTxPopup.h>

@interface LTxSettingForSipprFeedbackViewController ()
@property (nonatomic, strong) UITextView* opinionView;
@property (nonatomic, strong) UIButton* submitBtn;
@end

@implementation LTxSettingForSipprFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = LTxLocalizedString(@"text_setting_feed_back");
    [self setupComponents];
    [self addConstraintsOnComponents];
    
}
/*组件*/
-(void)setupComponents{
    //意见框
    _opinionView = [[UITextView alloc] init];
    _opinionView.translatesAutoresizingMaskIntoConstraints = NO;
    _opinionView.layer.cornerRadius = 5.f;
    _opinionView.clipsToBounds = YES;
    [self.view addSubview:_opinionView];
    
    //提交按钮
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setTitle:[NSString stringWithFormat:@"      %@      ",LTxLocalizedString(@"text_cmn_submit")] forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:[LTxCoreConfig sharedInstance].skinColor];
    _submitBtn.layer.cornerRadius = 5.f;
    _submitBtn.clipsToBounds = YES;
    [_submitBtn addTarget:self action:@selector(feedback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
}
/*约束*/
-(void)addConstraintsOnComponents{
    //意见框
    NSLayoutConstraint* opinionLeftConstraint = [NSLayoutConstraint constraintWithItem:_opinionView attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeftMargin multiplier:1.f constant:4];
    NSLayoutConstraint* opinionRightConstraint = [NSLayoutConstraint constraintWithItem:_opinionView attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRightMargin multiplier:1.f constant:-4];
    NSLayoutConstraint* opinionTopConstraint = [NSLayoutConstraint constraintWithItem:_opinionView attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.f constant:20];
    NSLayoutConstraint* opinionHeightConstraint = [NSLayoutConstraint constraintWithItem:_opinionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.25f constant:0];
    //提交按钮
    NSLayoutConstraint* btnTopConstraint = [NSLayoutConstraint constraintWithItem:_submitBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_opinionView attribute:NSLayoutAttributeBottom multiplier:1.f constant:10];
    NSLayoutConstraint* btnTrailinConstraint = [NSLayoutConstraint constraintWithItem:_submitBtn attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:_opinionView attribute:NSLayoutAttributeTrailingMargin multiplier:1.f constant:0];
    //激活约束，等价于单独设置约束.active = YES;
    [NSLayoutConstraint activateConstraints:@[opinionLeftConstraint,opinionRightConstraint,opinionTopConstraint,opinionHeightConstraint,btnTopConstraint,btnTrailinConstraint]];
}

/*反馈*/
-(void)feedback{
    [_opinionView resignFirstResponder];
    NSString* content = [_opinionView.text ltx_trimmingWhitespace];
    if ([content isEqualToString:@""]) {
        [self showErrorMessage:LTxLocalizedString(@"text_setting_feed_back_content_empty")];
        return;
    }
    _submitBtn.enabled = NO;
    [self showAnimatingActivityView];
    __weak __typeof(self) weakSelf = self;
    [LTxSettingForSipprViewModel userFeedbackWithOpinion:content complete:^(NSString *errorTips) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf hideAnimatingActivityView];
        if (!errorTips) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.navigationController popViewControllerAnimated:true];
                [strongSelf showErrorMessage:LTxLocalizedString(@"text_setting_feed_back_success")];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.submitBtn.enabled = YES;
                [strongSelf showErrorMessage:errorTips];
            });
        }
    }];
}

/**
 * 错误信息提示
 **/
-(void)showErrorMessage:(NSString*)errorMsg{
    LTxPopupToastConfiguration* configuration = [LTxPopupToastConfiguration defaultConfiguration];
    
    configuration.message = errorMsg;
    configuration.messageColor = [UIColor whiteColor];
    configuration.messageFontSize = 15.f;
    
    [LTxPopupToast showLTxPopupToastWithConfiguration:configuration show:^{
        //hook
    } tap:^{
        //hook
    } dismiss:^{
        //hook
    }];
}

@end
