//
//  SecondViewController.m
//  Demo
//
//  Created by TianMing on 16/3/9.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [[UIImage imageNamed:@"quanbao"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"left"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSDictionary * textAttribute = @{NSForegroundColorAttributeName:[UIColor redColor]};
        [self.tabBarItem setTitleTextAttributes:textAttribute forState:UIControlStateSelected];
        self.tabBarItem.title = @"书";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书";
    
}
-(void)viewDidAppear:(BOOL)animated{    
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
}
- (IBAction)nextViewController:(id)sender {
    ThirdViewController * third = [ThirdViewController new];
    [self.navigationController pushViewController:third animated:YES];
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
