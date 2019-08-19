//
//  MWRotationView.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWRotationView.h"

@interface MWRotationView ()

@property (nonatomic, retain) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval time_offset;
@property (nonatomic, assign) CFTimeInterval lastStep;

@end

@implementation MWRotationView

@synthesize stop = _stop, clockWise = _clockWise;

- (void)dealloc {
    [self.timer removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.timer invalidate];
    self.timer = nil;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat radius = MIN(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        
        _timer = nil;
        _time_offset = 0;
        _lastStep = 0;
        _stop = YES;
        _duration = 5;
        _clockWise = YES;
    }
    
    return self;
}

- (void)start {
    if (self.isStop) {
        [self animateAction];
    }
}

- (void)animateAction {
    [self.timer invalidate];
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _stop = NO;
}

- (void)stop {
    _stop = YES;
    [self.timer removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)step:(CADisplayLink *)timer {
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval diff = thisStep - self.lastStep;
    self.lastStep = thisStep;
    self.time_offset += diff;
    
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, [self angelByTime:self.time_offset]);
    self.layer.affineTransform = transform;
    
    if (self.time_offset >= _duration) {
        self.time_offset = 0;
    }
}



- (CGFloat)angelByTime:(CFTimeInterval )step {
    if (step > self.duration) {
        step = 0;
    }
    if (self.isClockWise) {
        return M_PI * 2 * step / self.duration;
    } else {
        return -M_PI * 2 * step / self.duration;
    }
    
}

@end
