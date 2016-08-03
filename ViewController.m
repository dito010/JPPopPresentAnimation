//
//  ViewController.m
//  JPPopPresentAnimation
//
//  Created by lava on 16/8/3.
//  Copyright © 2016年 lavaMusic. All rights reserved.
//

#import "ViewController.h"
#import "JPPresentVC.h"
#import "UIViewController+JPPopPresent.h"

@interface ViewController ()

/** 是否使用pop动画 */
@property(nonatomic, assign)BOOL popAnimationEnable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popAnimationEnable = YES;
}

#pragma mark --------------------------------------------------
#pragma mark Click Event

- (IBAction)presentBtnClick:(id)sender {
    
    JPPresentVC *presentVc = [JPPresentVC new];
    
    if (self.popAnimationEnable) {
        [self presentViewController:presentVc animated:YES completion:nil];
    }
    else{
        [self jp_presentViewController:presentVc animated:YES completion:nil];
    }
}

- (IBAction)usePopBtnClick:(UIButton *)sender {
    NSString *currentStatusString = sender.titleLabel.text;
    
    if ([currentStatusString isEqualToString:@"不使用Pop动画"]) {
        self.popAnimationEnable = NO;
        [sender setTitle:@"使用Pop动画" forState:UIControlStateNormal];
    }
    else if ([currentStatusString isEqualToString:@"使用Pop动画"]){
        self.popAnimationEnable = YES;
        [sender setTitle:@"不使用Pop动画" forState:UIControlStateNormal];
    }
}


@end
