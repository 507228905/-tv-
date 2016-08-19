//
//  ThirdViewController.m
//  Demo
//
//  Created by TianMing on 16/3/9.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "ThirdViewController.h"
#import "TMNavViewController.h"
#import "MeiViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [[UIImage imageNamed:@"help"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"left"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSDictionary * textAttribute = @{NSForegroundColorAttributeName:[UIColor redColor]};
        [self.tabBarItem setTitleTextAttributes:textAttribute forState:UIControlStateSelected];
        self.tabBarItem.title = @"我";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (IBAction)backTo:(id)sender {
    MeiViewController * vc = [MeiViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
