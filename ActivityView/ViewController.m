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


/** 网络请求状态是否成功 */
@property (nonatomic, assign) BOOL success;
/** 是否没有更多数据 */
@property (nonatomic, assign) BOOL noMoreData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //方式1
//    __weak ViewController *weakSelf = self;
//    [FHActivityView showInView:self.view activityWithBlock:^{
//        NSLog(@"网络请求代码");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            weakSelf.success = NO;
//            if (weakSelf.success)
//            {
//                weakSelf.noMoreData = YES;
//                if (weakSelf.noMoreData==YES)
//                {
//                    [FHActivityView endLoadInView:weakSelf.view message:@"数据加载完成，暂未更多信息" enable:NO];
//                }
//                else
//                {
//                    [FHActivityView hideFromView:weakSelf.view];
//                }
//            }
//            else
//            {
//                [FHActivityView endLoadInView:weakSelf.view message:@"网络错误，点击屏幕再次加载" enable:YES];
//            }
//        });
//    }];
    //方式2
    [FHActivityView showInView:self.view activityWithTarget:self action:@selector(finishAction)];
}

- (void)finishAction
{
    NSLog(@"网络请求代码");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.success = NO;
        if (self.success)
        {
            self.noMoreData = YES;
            if (self.noMoreData==YES)
            {
                [FHActivityView endLoadInView:self.view message:@"数据加载完成，暂未更多信息" enable:NO];
            }
            else
            {
                [FHActivityView hideFromView:self.view];
            }
        }
        else
        {
            [FHActivityView endLoadInView:self.view message:@"网络错误，点击屏幕再次加载" enable:YES];
        }
    });
}


@end
