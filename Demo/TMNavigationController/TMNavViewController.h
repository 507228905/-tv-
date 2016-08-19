//
//  TMNavViewController.h
//  Demo
//
//  Created by TianMing on 16/5/11.
//  Copyright © 2016年 TianMing. All rights reserved.
//
/**
 大家好，我叫天明。
 1，本工程不隐藏系统的navigationbar
 2，提供两种app常见的pop动画，动画效果从后往前、从左向右
 3，直接拖到工程中，不影响之前的代码
*/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PopAnimationType){
    PopAnimationTypeFromeBehind = 0, // 动画效果从后往前  默认效果
    PopAnimationTypeliner = 1, // 动画效果从左向右平滑
};
@interface TMNavViewController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, assign) PopAnimationType popAnimationType;
@property (nonatomic,assign) BOOL canDragBack;
@end
