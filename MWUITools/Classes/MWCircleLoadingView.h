//
//  MWCircleLoadingView.h
//  CircleLoadingView
//
//  Created by huangmingwei on 16/1/25.
//  Copyright © 2016年 huangmingwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWCircleLoadingView : UIView

// 线宽
// default is 1.0f
@property (nonatomic, assign) CGFloat lineWidth;

// 线的颜色
// default is [UIColor lightGrayColor]
@property (nonatomic, strong) UIColor *lineColor;

// 是否添加动画
// default is YES
@property (nonatomic, readonly, getter=isAnimating) BOOL animating;

// 开始、结束动画效果
- (void)startAnimation;

// 结束动画的时候会移除掉
- (void)stopAnimation;

@end
