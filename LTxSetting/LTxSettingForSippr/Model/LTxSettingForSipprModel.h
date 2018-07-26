//
//  LTxSettingForSipprModel.h
//  LTxSetting
//
//  Created by liangtong on 2018/7/25.
//  Copyright © 2018年 LTx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 数据持有层
 **/


/**
 * 更新历史
 **/
@interface LTxSettingForSipprHistoryModel : NSObject

/**
 * 编码
 **/
@property (nonatomic, copy) NSString* updateId;

/**
 * 版本
 **/
@property (nonatomic, copy) NSString* displayVersion;

/**
 * 内容
 **/
@property (nonatomic, copy) NSString* updateContent;

/**
 * Instance Method
 **/
+(instancetype)instanceWithUpdateId:(NSString*)updateId displayVersion:(NSString *)displayVersion updateContent:(NSString*)updateContent;

+(instancetype)instanceWithJSONString:(NSString*)jsonString;
+(instancetype)instanceWithDictionary:(NSDictionary*)dic;

@end
