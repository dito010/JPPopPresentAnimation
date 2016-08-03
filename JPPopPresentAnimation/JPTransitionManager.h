//
//  JPTransitionManager.h
//  JPPopPresentDemo
//
//  Created by Chris on 16/7/31.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>

// 保存时弹出还是收起的状态
@property (nonatomic, assign) BOOL isDismiss;

@end
