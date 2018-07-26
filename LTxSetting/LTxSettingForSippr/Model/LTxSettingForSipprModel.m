//
//  LTxSettingForSipprModel.m
//  LTxSetting
//
//  Created by liangtong on 2018/7/25.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import "LTxSettingForSipprModel.h"

/**
 * 更新历史
 **/
@implementation LTxSettingForSipprHistoryModel : NSObject

/**
 * Instance Method
 **/
+(instancetype)instanceWithUpdateId:(NSString*)updateId displayVersion:(NSString *)displayVersion updateContent:(NSString*)updateContent{
    LTxSettingForSipprHistoryModel* _instance = [[LTxSettingForSipprHistoryModel alloc] init];
    
    _instance.updateId = updateId;
    _instance.displayVersion = displayVersion;
    _instance.updateContent = updateContent;
    return _instance;
}

+(instancetype)instanceWithJSONString:(NSString*)jsonString{
    LTxSettingForSipprHistoryModel* _instance = [[LTxSettingForSipprHistoryModel alloc] init];
    
    //Convert String to Dictionary
    NSError* jsonError;
    NSDictionary *jsonDic =  [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
    if(!jsonError){
        [_instance setValuesForKeysWithDictionary:jsonDic];
    }
    
    return _instance;
}
+(instancetype)instanceWithDictionary:(NSDictionary*)dic{
    LTxSettingForSipprHistoryModel* _instance = [[LTxSettingForSipprHistoryModel alloc] init];
    if (dic) {
        [_instance setValuesForKeysWithDictionary:dic];
    }
    return _instance;
}
//映射用
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"displayVer"]) {
        self.displayVersion = value;
    }else if ([key isEqualToString:@"updateContent"]) {
        self.updateContent = value;
    }else if ([key isEqualToString:@"updateVer"]) {
        self.updateId = value;
    }
}
@end
