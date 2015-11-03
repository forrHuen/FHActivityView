//
//  FHActivityViewProtocol.h
//  EPIMApp
//
//  Created by Forr on 15/10/27.
//  Copyright © 2015年 Forr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ActivityBeginBlock)();

@protocol FHActivityViewProtocol <NSObject>

/** 活动显示器开始时回调 */
@property (nonatomic, copy)ActivityBeginBlock activityBlock;

/** 设置回调对象和回调方法 */
- (void)setActivityTarget:(id)target action:(SEL)action;
/** 回调对象 */
@property (nonatomic, weak) id activityTarget;
/** 回调方法 */
@property (nonatomic, assign) SEL activityAction;


/** 开始旋转活动 */
- (void)startActivityingWithStartTip:(NSString *)text;

/** 结束旋转活动 */
- (void)endActivityingEndTip:(NSString *)text;

/** 是否在旋转活动 */
- (BOOL)isActivitying;


@end
