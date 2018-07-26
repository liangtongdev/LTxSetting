//
//  LTxSettingForSipprUpdateHistoryTableViewCell.m
//  LTxSetting
//
//  Created by liangtong on 2018/7/25.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxSettingForSipprUpdateHistoryTableViewCell.h"
@interface LTxSettingForSipprUpdateHistoryTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *versionL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@end
@implementation LTxSettingForSipprUpdateHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(LTxSettingForSipprHistoryModel *)model{
    _model = model;
    if (model) {
        self.versionL.text = model.displayVersion;
        
        //修改行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.updateContent];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.updateContent length])];
        self.contentL.attributedText = attributedString;
    }
}
@end
