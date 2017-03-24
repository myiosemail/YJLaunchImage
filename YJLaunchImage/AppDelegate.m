//
//  AppDelegate.m
//  YJLaunchImage
//
//  Created by YJ on 2016/12/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AppDelegate.h"
#import "YJTabBarController.h"
#import "YJLaunchViewManager.h"
#import "YJAdModel.h"
#import "YJAdViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
       [self addMainWindow];
       [self addADLaunchController];
    return YES;
}
- (void)addMainWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[YJTabBarController alloc]init];
    [self.window makeKeyAndVisible];
}
- (void)addADLaunchController
{
    YJAdModel * adModel=[[YJAdModel alloc]init];
    adModel.launchUrl=@"http://d.hiphotos.baidu.com/image/pic/item/f7246b600c3387444834846f580fd9f9d72aa034.jpg";
    adModel.adDetailUrl=@"http://www.sina.com";
    UIViewController *rootViewController = self.window.rootViewController;
    YJLaunchViewManager *launchController = [YJLaunchViewManager launchViewManger];
    launchController.adModel=adModel;
    [launchController showView:rootViewController.view];
     __weak typeof(self)weakSelf=self;
    launchController.tapClick=^{
        YJAdViewController * adVc=[[YJAdViewController alloc]init];
        adVc.adModel=adModel;
        adVc.hidesBottomBarWhenPushed=YES;
        [weakSelf.window.rootViewController.childViewControllers[0] pushViewController:adVc animated:YES];
    };
}
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
@end
