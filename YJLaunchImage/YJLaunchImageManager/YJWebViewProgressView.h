//
//  YJWebViewProgressView.h
//  YJLaunchImage
//
//  Created by YJ on 2016/12/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJWebViewProgressView : UIView
/**
 如果未设置，则使用系统默认tintColor
 */
@property (nonatomic ,strong) UIColor *progressBarColor;
/**
 回到初始位置
 */
- (void)reset;
/**
 设置进度条位置
 @param progress 设置的进度条进度
 @param animated 是否需要动画
 */
- (void)setProgress:(float)progress animated:(BOOL)animated;
@end
