//
//  UIViewController+JPPopPresent.m
//  JPPopPresentDemo
//
//  Created by Chris on 16/7/30.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "UIViewController+JPPopPresent.h"
#import <objc/runtime.h>
#import "JPTransitionManager.h"

@interface UIViewController()

/** 动画管理者 */
@property(nonatomic, strong)JPTransitionManager *manager;

@end

@implementation UIViewController (JPPopPresent)

// 方法交换
+(void)load{
    // 系统的
    Method sys_present = class_getInstanceMethod(self, @selector(presentViewController:animated:completion:));
    Method sys_dismiss = class_getInstanceMethod(self, @selector(dismissViewControllerAnimated:completion:));
    
    // 自己的
    Method jp_present = class_getInstanceMethod(self, @selector(jp_presentViewController:animated:completion:));
    Method jp_dismiss = class_getInstanceMethod(self, @selector(jp_dismissViewControllerAnimated:completion:));
    
    // 交换
    method_exchangeImplementations(sys_present, jp_present);
    method_exchangeImplementations(sys_dismiss, jp_dismiss);
}

-(void)jp_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    
    self.modalTransitionStyle = UIModalPresentationCustom;
    viewControllerToPresent.transitioningDelegate = self;
    
    [self jp_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(void)jp_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self jp_dismissViewControllerAnimated:flag completion:completion];
}


#pragma mark -----------------------------------------
#pragma mark Accessor

-(void)setManager:(JPTransitionManager *)manager{
    objc_setAssociatedObject(self, @"manager", manager, OBJC_ASSOCIATION_RETAIN);
}

-(JPTransitionManager *)manager{
    return objc_getAssociatedObject(self, @"manager");
}

#pragma mark -----------------------------------------
#pragma mark UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.manager = [[JPTransitionManager alloc]init];
    self.manager.isDismiss = NO;
    return self.manager;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.manager.isDismiss = YES;
    return self.manager;
}

@end
