//
//  YJLaunchViewManager.m
//  YJLaunchImage
//
//  Created by YJ on 2016/12/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJLaunchViewManager.h"
#import "YJLaunchView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YJLaunchImage.h"
#import "YJAdViewController.h"
#import "YJAdModel.h"
@interface YJLaunchViewManager ()
@property (nonatomic, weak) YJLaunchView *launchView;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation YJLaunchViewManager
+(instancetype)launchViewManger
{
    return [[[ self class]alloc]init];
}
-(void)showView:(UIView *)view
{
    self.frame=view.bounds;
    [view addSubview:self];
    [self addADLaunchView];
    [self loadData];
}
- (void)addADLaunchView
{
    YJLaunchView *adLaunchView = [[YJLaunchView alloc]init];
    adLaunchView.skipBtn.hidden = YES;
    adLaunchView.launchImageView.image = [UIImage getLaunchImage];
    adLaunchView.frame=self.bounds;
    [adLaunchView.skipBtn addTarget:self action:@selector(skipADAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:adLaunchView];
    _launchView = adLaunchView;
}
- (void)loadData
{
    
    
    if ( _adModel.launchUrl&&_adModel.launchUrl.length>0) {
        [self showADImageWithURL:[NSURL URLWithString:_adModel.launchUrl]];
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAdController)];
        [_launchView addGestureRecognizer:tap];
    }else{
        [self dismissController];
    }
}
- (void)showADImageWithURL:(NSURL *)url
{
    __weak typeof(self) weakSelf = self;
    [_launchView.adImageView  sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 启动倒计时
        [weakSelf scheduledGCDTimer];
    } ];
}
- (void)showSkipBtnTitleTime:(int)timeLeave
{
    NSString *timeLeaveStr = [NSString stringWithFormat:@"跳过 %ds",timeLeave];
    [_launchView.skipBtn setTitle:timeLeaveStr forState:UIControlStateNormal];
    _launchView.skipBtn.hidden = NO;
}

- (void)scheduledGCDTimer
{
    [self cancleGCDTimer];
    __block int timeLeave = DURATION; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeLeave <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //关闭界面
                [self dismissController];
            });
        }else{
            int curTimeLeave = timeLeave;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面
                [weakSelf showSkipBtnTitleTime:curTimeLeave];
                
            });
            --timeLeave;
        }
    });
    dispatch_resume(_timer);
}

- (void)cancleGCDTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

#pragma mark - action

- (void)skipADAction
{
    [self dismissController];
}

- (void)dismissController
{
    [self cancleGCDTimer];
    //消失动画
    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //缩放修改处
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)pushAdController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        YJAdViewController * adVc=[[YJAdViewController alloc]init];
        adVc.adModel=self.adModel;
        adVc.hidesBottomBarWhenPushed=YES;
        [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0] pushViewController:adVc animated:YES];
    });
}
- (void)dealloc
{
    [self cancleGCDTimer];
}
-(void)show
{
    [self addADLaunchView];
    [self loadData];
}
@end
