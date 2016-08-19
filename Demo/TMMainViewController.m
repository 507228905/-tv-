//
//  TMViewController.m
//  Demo
//
//  Created by TianMing on 16/3/17.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "TMMainViewController.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "AppDelegate.h"
#import "TMNavViewController.h"

@interface TMMainViewController ()

@property (strong , nonatomic) UITabBarController * tabbar;
@end

@implementation TMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabbar = [[UITabBarController alloc]init];
    ViewController * view1 = [ViewController new];
    SecondViewController * view2 = [SecondViewController new];
    ThirdViewController * view3 = [ThirdViewController new];
    UINavigationController * nav1 = [[UINavigationController alloc]initWithRootViewController:view1];
    TMNavViewController* nav2 = [[TMNavViewController alloc]initWithRootViewController:view2];
  //  nav2.popAnimationType = 1; 默认pop动画为从后往前
    TMNavViewController * nav3 = [[TMNavViewController alloc]initWithRootViewController:view3];
    _tabbar.viewControllers = @[nav1,nav2,nav3];
    [self performSelector:@selector(gotoWindow) withObject:self afterDelay:0];
}
-(void)gotoWindow{
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = _tabbar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
