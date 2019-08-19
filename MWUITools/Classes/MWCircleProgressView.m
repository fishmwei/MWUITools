//
//  MWCircleProgressView.m
//  Pods
//
//  Created by huangmingwei on 16/7/12.
//
//

#import "MWCircleProgressView.h"


@interface MWCircleProgressView ()

@property (nonatomic, retain) CAShapeLayer *bgLayer;
@property (nonatomic, retain) CAShapeLayer *frontLayer; //progress layer
@property (nonatomic, assign) CGFloat radius;

@end

@implementation MWCircleProgressView

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        
        _radius = MIN(width/2, height/2);
        _coverWidth = 5;
        _bgColor = [UIColor clearColor];
        _strokeColor = [UIColor whiteColor];
        
        [self initUI];
    }
    
    return self;
}

-(UIBezierPath *)generatePath {
    
    UIBezierPath *apath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:_radius startAngle:M_PI*3/2 endAngle:M_PI*7/2 clockwise:YES];
    
    return apath;
}

-(void)initUI {
    UIBezierPath *circlePath  = [self generatePath];
    
    _bgLayer = [[CAShapeLayer alloc] init];
    _bgLayer.frame = self.bounds;
    _bgLayer.fillColor = nil;
    _bgLayer.strokeColor = _bgColor.CGColor;
    _bgLayer.path = circlePath.CGPath;
    _bgLayer.lineCap = kCALineCapRound;
    _bgLayer.lineWidth = _coverWidth;
    [self.layer addSublayer:_bgLayer];
    
    //进度圈
    _frontLayer = [[CAShapeLayer alloc] init];
    _frontLayer.frame = self.bounds;
    _frontLayer.fillColor = nil;
    _frontLayer.strokeColor = _strokeColor.CGColor;
    _frontLayer.path = circlePath.CGPath;
    _frontLayer.lineCap = kCALineCapRound;
    _frontLayer.lineWidth = _coverWidth;
    [self.layer addSublayer:_frontLayer];
    _frontLayer.strokeEnd = 0; //初始显示为0
}

- (void)updateProgress:(CGFloat)progress {
    _frontLayer.strokeEnd = progress > 1 ? 1 : progress;
}

- (void)setBgColor:(UIColor *)bgColor {
    
    if (_bgLayer) {
        _bgLayer.strokeColor = bgColor.CGColor;
    }
    
    _bgColor = bgColor;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    
    if (_frontLayer) {
        _frontLayer.strokeColor = strokeColor.CGColor;
    }
    
    _strokeColor = strokeColor;
}

- (void)setCoverWidth:(CGFloat)coverWidth {
    
    if (_frontLayer) {
        _frontLayer.lineWidth = coverWidth;
    }
    
    if (_bgLayer) {
        _bgLayer.lineWidth = coverWidth;
    }
    
    _coverWidth = coverWidth;
}


@end
