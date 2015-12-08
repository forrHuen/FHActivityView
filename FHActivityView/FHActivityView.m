//
//  FHActivityView.m
//  EPIMApp
//
//  Created by Forr on 15/10/27.
//  Copyright © 2015年 Forr. All rights reserved.
//

#import "FHActivityView.h"
#import <objc/message.h>

@interface FHActivityView ()

/**
 *  关于子控件在Y轴上开始时坐标大小的约束
 */
@property (nonatomic, strong) NSArray *vBeginConstranints;
/**
 *  关于子控件在Y轴上结束时坐标大小的约束
 */
@property (nonatomic, strong) NSArray *vEndConstranints;

/** 活动显示器 */
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
/** 提示文本按钮 */
@property (nonatomic, strong) UIButton *tipButton;

@end


@implementation FHActivityView

@synthesize activityBlock = _activityBlock;
@synthesize activityAction = _activityAction;
@synthesize activityTarget = _activityTarget;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.translatesAutoresizingMaskIntoConstraints = NO;
        [activityView startAnimating];
        [self addSubview:activityView];
        self.activityIndicatorView = activityView;
        
        UIButton *button = [[UIButton alloc] init];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitleColor:activityView.color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button addTarget:self action:@selector(onceAgainAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.tipButton = button;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(activityView, button);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[activityView]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]|" options:0 metrics:nil views:views]];
        self.vBeginConstranints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[activityView][button(25)]|" options:0 metrics:nil views:views];
        self.vEndConstranints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button(60)]|" options:0 metrics:nil views:views];
    }
    return self;
}

- (void)onceAgainAction:(UIButton *)button
{
     FHActivityView *currentView = (FHActivityView *)button.superview;
    [currentView startActivityingWithStartTip:nil];
}


/** 设置加载block */
- (void)activityWithBlock:(ActivityBeginBlock )activityBlock
{
    FHActivityView *currentView = (FHActivityView *)[self.superview viewWithTag:2048];
    currentView.activityBlock = activityBlock;
}

/** 设置加载targetAction */
- (void)activityWithTarget:(id)target action:(SEL)action
{
    FHActivityView *currentView = (FHActivityView *)[self.superview viewWithTag:2048];
    [currentView setActivityTarget:target action:action];
}

/** 设置回调对象和回调方法 */
- (void)setActivityTarget:(id)target action:(SEL)action
{
    self.activityTarget = target;
    self.activityAction = action;
}


/** 开始旋转活动 */
- (void)startActivityingWithStartTip:(NSString *)text
{
    if (text.length==0 || text==nil) {
        text = @"卖力加载中...";
    }
    [self removeConstraints:self.vEndConstranints];
    [self addConstraints:self.vBeginConstranints];
    [self.superview layoutIfNeeded];
    [self.tipButton setTitle:text forState:UIControlStateNormal];
    [self.activityIndicatorView startAnimating];
    if (self.activityBlock)
    {
        self.activityBlock();
    }
    if (self.activityTarget && self.activityAction &&
        [self.activityTarget respondsToSelector:self.activityAction])
    {
        objc_msgSend(self.activityTarget,self.activityAction);
    }
}

/** 结束旋转活动 */
- (void)endActivityingEndTip:(NSString *)text
{
    [self.tipButton setTitle:text forState:UIControlStateNormal];
    [self.activityIndicatorView stopAnimating];
    [self removeConstraints:self.vBeginConstranints];
    [self addConstraints:self.vEndConstranints];
    [self.superview layoutIfNeeded];
}

/** 是否在旋转活动 */
- (BOOL)isActivitying
{
    return [self.activityIndicatorView
     isAnimating];
}

/** 显示加载视图,并设置block */
+ (instancetype )showInView:(UIView *)view activityWithBlock:(ActivityBeginBlock )activityBlock
{
    FHActivityView *currentView = (FHActivityView *)[view viewWithTag:2048];
    if (!currentView)
    {
        currentView = [[FHActivityView alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        currentView.tag = 2048;
        currentView.center = view.center;
        currentView.activityBlock = activityBlock;
        [view addSubview:currentView];
    }
    [currentView startActivityingWithStartTip:nil];
    return currentView;
}

/** 显示加载视图,并设置targetAction */
+ (instancetype )showInView:(UIView *)view activityWithTarget:(id)target action:(SEL)action
{
    FHActivityView *currentView = (FHActivityView *)[view viewWithTag:2048];
    if (!currentView)
    {
        currentView = [[FHActivityView alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        currentView.tag = 2048;
        currentView.center = view.center;
        [currentView setActivityTarget:target action:action];
        [view addSubview:currentView];
    }
    [currentView startActivityingWithStartTip:nil];
    return currentView;
}


+ (void)hideFromView:(UIView *)view
{
    FHActivityView *currentView = (FHActivityView *)[view viewWithTag:2048];
    currentView.hidden = YES;
    currentView.tipButton.hidden = YES;
    [currentView.activityIndicatorView stopAnimating];
}


+ (void)endLoadInView:(UIView *)view message:(NSString *)tip enable:(BOOL)enable
{
    FHActivityView *currentView = (FHActivityView *)[view viewWithTag:2048];
    currentView.hidden = NO;
    currentView.tipButton.hidden = NO;
    [currentView endActivityingEndTip:tip];
    currentView.tipButton.enabled = enable;
}

+ (void)startLoadInView:(UIView *)view
{
    FHActivityView *currentView = (FHActivityView *)[view viewWithTag:2048];
    [currentView startActivityingWithStartTip:nil];
}

@end
