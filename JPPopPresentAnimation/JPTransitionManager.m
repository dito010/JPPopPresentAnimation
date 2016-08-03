//
//  JPTransitionManager.m
//  JPPopPresentDemo
//
//  Created by Chris on 16/7/31.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPTransitionManager.h"


#define ScreenHeight [[UIScreen mainScreen]bounds].size.height

@implementation JPTransitionManager

#pragma mark --------------------------------------------------
#pragma mark 转场委托实现

// 转场动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isDismiss) {
        return 0.3;
    }
    else{
        return 0.34;
    }
}

// 转场动画具体实现
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 获取转场的两个视图控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 获取产生转场的容器view
    UIView *containerView = [transitionContext containerView];
    
    if (!self.isDismiss)// 弹出
    {
        CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = CGRectOffset(finalRect, 0, ScreenHeight);
        [containerView addSubview:toVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            // 弹出视图控制器
            toVC.view.frame = finalRect;
        } completion:^(BOOL finished) {
            // 标记结束
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
        // 弹出动画
        [UIView animateWithDuration:[self transitionDuration:transitionContext] / 1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [fromVC.view.layer setTransform:[self firstTransform]];
        } completion:nil];
        
    }
    else // 收起
    {
        // 获得当前frame
        CGRect initRect = [transitionContext initialFrameForViewController:fromVC];
        CGRect finalRect = CGRectOffset(initRect, 0, ScreenHeight);
        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
        
        // 收起动画
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            // 回到初始位置
            [toVC.view.layer setTransform:CATransform3DIdentity];
            
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 收起视图控制器
            fromVC.view.frame = finalRect;
            
        } completion:^(BOOL finished) {
            // 标记结束
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
}

#pragma mark - 变换操作
- (CATransform3D )firstTransform{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, 0.92, 0.92, 1);
    
    return transform;
}

@end
