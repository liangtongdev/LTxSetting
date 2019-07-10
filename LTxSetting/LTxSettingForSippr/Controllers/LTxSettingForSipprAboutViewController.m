//
//  LTxSettingForSipprAboutViewController.m
//  LTxSetting
//
//  Created by liangtong on 2018/7/25.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxSettingForSipprAboutViewController.h"
#import "LTxSettingForSipprUpdateHistoryTableViewController.h"

@interface LTxSettingForSipprAboutViewController ()
@property (nonatomic, strong) UILabel* appNameL;
@property (nonatomic, strong) UILabel* versionL;
@property (nonatomic, strong) UIButton* historyBtn;

@property (nonatomic, strong) UILabel* tipL1;
@property (nonatomic, strong) UILabel* tipL2;
@end

@implementation LTxSettingForSipprAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = LTxLocalizedString(@"text_setting_about");
    
    [self setupComponents];
    [self addConstraintsOnComponents];
}

-(void)setupComponents{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    //应用名称
    _appNameL = [[UILabel alloc] init];
    _appNameL.translatesAutoresizingMaskIntoConstraints = NO;
    _appNameL.text = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    _appNameL.textColor = [UIColor darkGrayColor];
    _appNameL.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:_appNameL];
    
    //版本信息
    _versionL = [[UILabel alloc] init];
    _versionL.translatesAutoresizingMaskIntoConstraints = NO;
    NSString* versionText;
    if ([LTxCoreConfig sharedInstance].isDebug) {
        versionText = [NSString stringWithFormat:@"%@：v%@ T",LTxLocalizedString(@"text_setting_about_current_version"),[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    }else{
        versionText = [NSString stringWithFormat:@"%@：v%@",LTxLocalizedString(@"text_setting_about_current_version"),[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    }
    _versionL.text = versionText;
    _versionL.textColor = [UIColor grayColor];
    _versionL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_versionL];
    
    //更新历史按钮
    _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _historyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_historyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_historyBtn setTitle:[NSString stringWithFormat:@"   %@   ",LTxLocalizedString(@"text_setting_about_history")] forState:UIControlStateNormal];
    [_historyBtn setBackgroundColor:[UIColor whiteColor]];
    _historyBtn.layer.cornerRadius = 5.f;
    _historyBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _historyBtn.layer.borderWidth = 1.f;
    _historyBtn.clipsToBounds = YES;
    [_historyBtn addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_historyBtn];
    
    
    _tipL1 = [[UILabel alloc] init];
    _tipL1.translatesAutoresizingMaskIntoConstraints = NO;
    _tipL1.text = [LTxCoreConfig sharedInstance].aboutTip1;
    _tipL1.numberOfLines = 0;
    _tipL1.font = [UIFont systemFontOfSize:11];
    _tipL1.textColor = [UIColor darkGrayColor];
    [self.view addSubview:_tipL1];
    
    _tipL2 = [[UILabel alloc] init];
    _tipL2.translatesAutoresizingMaskIntoConstraints = NO;
    _tipL2.text = [LTxCoreConfig sharedInstance].aboutTip2;
    _tipL2.numberOfLines = 0;
    _tipL2.font = [UIFont systemFontOfSize:9];
    _tipL2.textColor = [UIColor darkGrayColor];
    [self.view addSubview:_tipL2];
}

-(void)addConstraintsOnComponents{
    //应用名称约束
    NSLayoutConstraint* nameXConstraint = [NSLayoutConstraint constraintWithItem:_appNameL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
    NSLayoutConstraint* nameYConstraint = [NSLayoutConstraint constraintWithItem:_appNameL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.f constant:-100];
    
    //版本约束
    NSLayoutConstraint* versionXConstraint = [NSLayoutConstraint constraintWithItem:_versionL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_appNameL attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
    NSLayoutConstraint* versionTopConstraint = [NSLayoutConstraint constraintWithItem:_versionL attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_appNameL attribute:NSLayoutAttributeBottom multiplier:1.f constant:20];
    
    //更新按钮
    NSLayoutConstraint* btnXConstraint = [NSLayoutConstraint constraintWithItem:_historyBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_appNameL attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
    NSLayoutConstraint* btnTopConstraint = [NSLayoutConstraint constraintWithItem:_historyBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_versionL attribute:NSLayoutAttributeBottom multiplier:1.f constant:20];
    
    //提示 - 版权
    NSLayoutConstraint* t2Leading = [NSLayoutConstraint constraintWithItem:_tipL2 attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.f constant:8];
    NSLayoutConstraint* t2Trailing = [NSLayoutConstraint constraintWithItem:_tipL2 attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.f constant:-8];
    NSLayoutConstraint* t2Bottom = [NSLayoutConstraint constraintWithItem:_tipL2 attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1.f constant:-8.f];
    
    NSLayoutConstraint* t1Leading = [NSLayoutConstraint constraintWithItem:_tipL1 attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.f constant:8];
    NSLayoutConstraint* t1Trailing = [NSLayoutConstraint constraintWithItem:_tipL1 attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.f constant:-8];
    NSLayoutConstraint* t1Bottom = [NSLayoutConstraint constraintWithItem:_tipL1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_tipL2 attribute:NSLayoutAttributeTop multiplier:1.f constant:-6.f];
    
    //激活约束，等价于单独设置约束.active = YES;
    [NSLayoutConstraint activateConstraints:@[nameXConstraint,nameYConstraint,
                                              versionXConstraint,versionTopConstraint,
                                              btnXConstraint,btnTopConstraint,
                                              t2Leading,t2Trailing,t2Bottom,
                                              t1Leading,t1Trailing,t1Bottom]];
}

-(void)showHistory{
    LTxSettingForSipprUpdateHistoryTableViewController* historyVC = [[LTxSettingForSipprUpdateHistoryTableViewController alloc] init];
    [self.navigationController pushViewController:historyVC animated:true];
}
@end
