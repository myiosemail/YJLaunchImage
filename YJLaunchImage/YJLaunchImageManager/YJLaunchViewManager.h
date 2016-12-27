//
//  YJLaunchViewManager.h
//  YJLaunchImage
//
//  Created by YJ on 2016/12/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

//广告倒计时间 单位：秒
#define DURATION 5
@class YJAdModel;
@interface YJLaunchViewManager : UIView
/** 广告模型*/
@property (nonatomic , strong) YJAdModel  *adModel;
/**
 创建一个对象
 */
+(instancetype)launchViewManger;
/**
 展示对象
 */
-(void)showView:(UIView *)view;
@end
