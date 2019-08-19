//
//  MWDrawView.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWCAShapeDrawView.h"


@interface MWCAShapeDrawView ()

@property (nonatomic, retain) UIBezierPath *path;

@end

@implementation MWCAShapeDrawView

+ (Class)layerClass {
    
    return [CAShapeLayer class];
}


-(void)awakeFromNib {
    //create a mutable path
    self.path = [[UIBezierPath alloc] init];
    
    //configure the layer
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5;
}


- (id)init {
    self = [super init];
    [self awakeFromNib];
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    //move the path drawing cursor to the starting point
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //get the current point
    CGPoint point = [[touches anyObject] locationInView:self];
    //add a new line segment to our path
    [self.path addLineToPoint:point];
    //update the layer with a copy of the path
 
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = strokeColor.CGColor;
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.fillColor = fillColor.CGColor;
}
@end
