//
//  UIViewController+JPPopPresent.h
//  JPPopPresentDemo
//
//  Created by Chris on 16/7/30.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JPPopPresent)<UIViewControllerTransitioningDelegate>

/**
 *  弹出控制器
 */
-(void)jp_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;

/**
 *  销毁控制器
 */
- (void)jp_dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;

@end
