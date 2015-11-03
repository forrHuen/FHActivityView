//
//  ViewController.m
//  ActivityView
//
//  Created by Forr on 15/11/3.
//  Copyright © 2015年 Forr. All rights reserved.
//

#import "ViewController.h"
#import "FHActivityView.h"

@interface ViewController ()


@property (nonatomic, strong) FHActivityView *activityView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [FHActivityView showInView:self.view activityWithBlock:^{
//        NSLog(@"网络请求代码");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [FHActivityView removeFromView:self.view];
//            [FHActivityView endLoadFromView:self.view messager:@"网络错误" enable:NO];
//        });
//    }];
    [FHActivityView showInView:self.view activityWithTarget:self action:@selector(finishAction)];
}

- (void)finishAction
{
    NSLog(@"网络请求代码");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [FHActivityView removeFromView:self.view];
        [FHActivityView endLoadInView:self.view message:@"网络错误,点击屏幕再次加载" enable:YES];
    });
}


@end
