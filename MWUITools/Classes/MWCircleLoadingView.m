//
//  MWCircleLoadingView.m
//  CircleLoadingView
//
//  Created by huangmingwei on 16/1/25.
//  Copyright © 2016年 huangmingwei. All rights reserved.
//

#import "MWCircleLoadingView.h"

@interface MWCircleLoadingView ()
{
    CAShapeLayer *circleLayer;
}
/// 角度
// 0.0 - 1.0
@property (nonatomic, assign) CGFloat angel;

@end


@implementation MWCircleLoadingView



#define kAngelWithDegree(degree) (2 * M_PI / 360 * degree)




- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (void)setAngel:(CGFloat)angel {
    _angel = angel;
    [self setNeedsDisplay];
    return;
}

- (void)startAnimation {
    if (self.isAnimating) {
        
        return;
//        [self stopAnimation];
//        [self.layer removeAllAnimations];
    }

    _isAnimating = YES;
    
    self.angel = kAngelWithDegree(50);
    [self startRotateAnimation];
    return;
}

- (void)stopAnimation {
    _isAnimating = NO;
    [self stopRotateAnimation];
    return;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_isAnimating)
    {
        //变慢点,每秒钟定时重启动画
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startRotateAnimation) userInfo:nil repeats:NO];
    }
}

- (void)startRotateAnimation {
    
    if (!_isAnimating) {
        return;
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    animation.duration = 1.0f;
    animation.autoreverses = NO;
    animation.repeatCount = INT_MAX;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];

 
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished)
     {

     }];
    
    
    return;
}

- (void)stopRotateAnimation {
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        _angel = 0;
        [self.layer removeAllAnimations];
    }];
    return;
}

- (void)drawRect:(CGRect)rect {
    if (self.angel <= 0) {
        _angel = 0;
    }
    
    CGFloat lineWidth = 1.f;
    UIColor *lineColor = [UIColor blueColor];
    if (self.lineWidth) {
        lineWidth = self.lineWidth;
    }
    if (self.lineColor) {
        lineColor = self.lineColor;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextAddArc(context,
                    CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds),
                    CGRectGetWidth(self.bounds)/2-lineWidth,
                    kAngelWithDegree(120),
                    kAngelWithDegree(120) + kAngelWithDegree(330) * self.angel,
                    0);
    CGContextStrokePath(context);
    return;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
