//
//  YJTabBarController.h
//  YJLaunchImage
//
//  Created by YJ on 2016/12/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTabBarController.h"
#import "FirstViewController.h"
@interface YJTabBarController ()
@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFirstController];
}

- (void)addFirstController
{
    FirstViewController *firstController = [[FirstViewController alloc]init];
    // 给控制器 包装 一个导航控制器
    UINavigationController *   nav = [[UINavigationController alloc] initWithRootViewController:firstController];
    // 添加为子控制器
    [self addChildViewController:nav];
}

@end
