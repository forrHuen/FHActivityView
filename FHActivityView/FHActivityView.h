//
//  FHActivityView.h
//  EPIMApp
//
//  Created by Forr on 15/10/27.
//  Copyright © 2015年 Forr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHActivityViewProtocol.h"

@interface FHActivityView : UIView<FHActivityViewProtocol>

/**
 *  初始化加载视图
 *
 *  @param view          父视图
 *  @param activityBlock block回调
 *
 *  @return 目标对象
 */
+ (instancetype )showInView:(UIView *)view
    activityWithBlock:(ActivityBeginBlock)activityBlock;


/**
 *  初始化加载视图
 *
 *  @param view   父视图
 *  @param target
 *  @param action
 *
 *  @return 目标对象
 */
+ (instancetype )showInView:(UIView *)view
    activityWithTarget:(id)target
            action:(SEL)action;


/**
 *  从父视图中隐藏加载视图
 *
 *  @param view 父视图
 */
+ (void)hideFromView:(UIView *)view;

/**
 *  结束加载动作
 *
 *  @param view   父视图
 *  @param tip    结束语
 *  @param enable 是否支持再次加载
 */
+ (void)endLoadInView:(UIView *)view
              message:(NSString *)tip
               enable:(BOOL)enable;

/**
 *  开始加载视图动作
 *
 *  @param view 父视图
 */
+ (void)startLoadInView:(UIView *)view;

@end
