//
//  TMNavViewController.m
//  Demo
//
//  Created by TianMing on 16/5/11.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "TMNavViewController.h"

#define S_WIDTH [UIScreen mainScreen].bounds.size.width
#define S_HEIGHT [UIScreen mainScreen].bounds.size.height
#define K_WINDOW [[UIApplication sharedApplication] keyWindow]
#define T_VIEW  [[UIApplication sharedApplication] keyWindow].rootViewController.view
#define TOUCH_DISTANCE  150

@interface TMNavViewController ()

@property (nonatomic , strong) NSMutableArray * snapArray;
@property (nonatomic , assign) CGPoint  startPoint;
@property (nonatomic , strong) UIView * backgroundView;
@property (nonatomic , strong) UIView *blackMask;
@property(nonatomic,strong) UIImageView * lastScreenShotImageView;
@property (nonatomic,assign) BOOL isMoving;

@end

@implementation TMNavViewController
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.snapArray = [NSMutableArray arrayWithCapacity:2];
        self.canDragBack = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanGestureRecognizer:)];
    panRecognizer.delegate = self;
    [self.view addGestureRecognizer:panRecognizer];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:(BOOL)animated];
    if (self.snapArray.count == 0) {
        UIImage *capturedImage = [self capture];
        [self.snapArray addObject:capturedImage];
    }
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self capture]) {
        [self.snapArray addObject:[self capture]];
    }
    if (self.viewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
-(UIViewController*)popViewControllerAnimated:(BOOL)animated{
   [self.snapArray removeLastObject];
   return [super popViewControllerAnimated:animated];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.viewControllers.count <= 1 || !self.canDragBack) return NO;
    return YES;
}
-(void)didPanGestureRecognizer:(UIPanGestureRecognizer*)pan{
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    CGPoint touchPoint = [pan locationInView:K_WINDOW];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startPoint = touchPoint;
        _isMoving = YES;
        [self addSnapView];
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        if (touchPoint.x - self.startPoint.x>TOUCH_DISTANCE) {
            [UIView animateWithDuration:0.3 animations:^{
                [self doMoveViewWithX:S_WIDTH];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                [self popViewControllerAnimated:NO];
                CGRect frame = T_VIEW.frame;
                frame.origin.x = 0;
                T_VIEW.frame = frame;
                self.backgroundView.hidden = YES;
            }];
        }else {
            [UIView animateWithDuration:0.3 animations:^{
                [self doMoveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
        }
        return;
    }else if (pan.state == UIGestureRecognizerStateCancelled){
        [UIView animateWithDuration:0.3 animations:^{
            [self doMoveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        return;
    }
    if (_isMoving) {
        [self doMoveViewWithX:touchPoint.x - self.startPoint.x];
    }
}
-(void)addSnapView{
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        [T_VIEW.superview insertSubview:self.backgroundView belowSubview:T_VIEW];
        self.blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_WIDTH , S_HEIGHT)];
        self.blackMask.backgroundColor = [UIColor blackColor];
        [self.backgroundView addSubview:self.blackMask];
    }
    self.backgroundView.hidden = NO;
    if (self.lastScreenShotImageView) { [self.lastScreenShotImageView removeFromSuperview]; }
    UIImage *lastScreenShot = [self.snapArray lastObject];
    self.lastScreenShotImageView = [[UIImageView alloc] initWithImage:lastScreenShot];
    self.lastScreenShotImageView.frame = CGRectMake(0, 0, S_WIDTH,S_HEIGHT);
    [self.backgroundView insertSubview:self.lastScreenShotImageView belowSubview:self.blackMask];
}
- (UIImage *)capture{
    UIGraphicsBeginImageContextWithOptions(T_VIEW.bounds.size, T_VIEW.opaque, 0.0);
    [T_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(void)doMoveViewWithX:(CGFloat)x{
    x = x>S_WIDTH?S_WIDTH:x;
    x = x<0?0:x;
    CGRect frame = T_VIEW.frame;
    frame.origin.x = x;
    T_VIEW.frame = frame;
    switch (_popAnimationType) {
        case 0:
            [self animateionFromBehind:x];
            break;
        case 1:
            [self animationLiner:x];
            break;
        default:
            break;
    }
}
-(void)animateionFromBehind:(CGFloat)x{
    float coefficient = S_WIDTH*25;
    float scale = (x/coefficient)+0.96;
    float alpha = 0.4 - (x/800);
    _lastScreenShotImageView.transform = CGAffineTransformMakeScale(scale, scale);
    _blackMask.alpha = alpha;
}
-(void)animationLiner:(CGFloat)x{
    float coefficient = x/2;
    CGRect screenShotImageViewFrame = _lastScreenShotImageView.frame;
    screenShotImageViewFrame.origin.x = -S_WIDTH/2 + coefficient;
    _lastScreenShotImageView.frame = screenShotImageViewFrame;
    _blackMask.alpha = 0.3;
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    self.snapArray = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
}


@end
