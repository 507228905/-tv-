//
//  ViewController.m
//  Demo
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "TMNavViewController.h"

@interface ViewController ()

@end

@implementation ViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [[UIImage imageNamed:@"contact"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSDictionary * textAttribute = @{NSForegroundColorAttributeName:[UIColor redColor]};
        [self.tabBarItem setTitleTextAttributes:textAttribute forState:UIControlStateSelected];
        self.tabBarItem.title = @"首页";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
}

- (IBAction)go:(id)sender {
    [self gogo];
}
-(void)gogo{
    SecondViewController * controller = [SecondViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
