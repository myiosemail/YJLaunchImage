//
//  YJAdModel.h
//  YJLaunchImage
//
//  Created by YJ on 2016/12/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJAdModel : NSObject
/** 启动图广告地址*/
@property (nonatomic , copy) NSString *launchUrl;
/** 启动图广告详情地址*/
@property (nonatomic , copy) NSString *adDetailUrl;
@end
