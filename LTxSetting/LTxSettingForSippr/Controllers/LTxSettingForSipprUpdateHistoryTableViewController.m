//
//  LTxSettingForSipprUpdateHistoryTableViewController.m
//  LTxSetting
//
//  Created by liangtong on 2018/7/25.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxSettingForSipprUpdateHistoryTableViewController.h"
#import "LTxSettingForSipprUpdateHistoryTableViewCell.h"
#import "LTxSettingForSipprViewModel.h"

@interface LTxSettingForSipprUpdateHistoryTableViewController ()
@property (nonatomic, strong) NSMutableArray* dataSource;
@end
static NSString* LTxSettingForSipprUpdateHistoryTableViewCellIdentifier = @"LTxSettingForSipprUpdateHistoryTableViewCellIdentifier";
@implementation LTxSettingForSipprUpdateHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefaultConfig];
    
    [self showAnimatingActivityView];
    [self updateHistoryFetch];
}

-(void)setupDefaultConfig{
    
    self.title = LTxLocalizedString(@"text_setting_about_history");
    
    self.tableView.estimatedRowHeight = 60.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"LTxSettingForSipprUpdateHistoryTableViewCell" bundle:SelfBundle] forCellReuseIdentifier:LTxSettingForSipprUpdateHistoryTableViewCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak __typeof(self) weakSelf = self;
    [self addPullDownRefresh:^{
        [weakSelf updateHistoryFetch];
    }];
}

-(void)updateHistoryFetch{
    __weak __typeof(self) weakSelf = self;
    [LTxSettingForSipprViewModel appUpdateHistoryFetchComplete:^(NSString *errorTips, NSArray *updateHistory) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.dataSource = [updateHistory mutableCopy];
        strongSelf.errorTips = errorTips;
        [strongSelf finishSipprRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LTxSettingForSipprUpdateHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LTxSettingForSipprUpdateHistoryTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[LTxSettingForSipprUpdateHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LTxSettingForSipprUpdateHistoryTableViewCellIdentifier];
    }
    NSDictionary* updateDic = [self.dataSource objectAtIndex:indexPath.row];
    cell.model = [LTxSettingForSipprHistoryModel instanceWithDictionary:updateDic];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
