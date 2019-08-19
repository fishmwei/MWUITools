//
//  MWCGDrawView.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/29.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "MWCGDrawView.h"

@interface MWCGDrawView ()

@property (nonatomic, strong) NSMutableArray *strokes;
@property (nonatomic, retain) UIImage *image;
@end

@implementation MWCGDrawView

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"MWDrawColor"];
}

- (void)awakeFromNib {
    
    self.strokes = [NSMutableArray array];
}

- (id)init {
    self = [super init];
    if (self) {
        self.layer.drawsAsynchronously = YES;
        [self awakeFromNib];
        self.MWCGDrawWidth = 10;
        self.MWDrawColor = [UIColor redColor];
        self.image = [self imageWithColor:self.MWDrawColor];
        [self addObserver:self forKeyPath:@"MWDrawColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    //add brush stroke
    [self addBrushStrokeAtPoint:point];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self];
    //add brush stroke
    [self addBrushStrokeAtPoint:point];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point {
    //add brush stroke to array
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    
    //needs redraw
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf setNeedsDisplayInRect:[self brushRectForPoint:point]];
    });
    
    
//    [self setNeedsDisplay];
}

- (CGRect)brushRectForPoint:(CGPoint)point {
    return CGRectMake(point.x - _MWCGDrawWidth, point.y - _MWCGDrawWidth, _MWCGDrawWidth*2, _MWCGDrawWidth*2);
}

- (void)drawRect:(CGRect)rect {
    //redraw strokes
    for (NSValue *value in self.strokes) {
        //get point
        CGPoint point = [value CGPointValue];
        //get brush rect
        CGRect brushRect = [self brushRectForPoint:point];
        //only draw brush stroke if it intersects dirty rect
        if (CGRectIntersectsRect(rect, brushRect)) {
            //draw brush stroke
            [self.image drawInRect:brushRect];
        }
    }
}

-(UIImage *)imageWithColor:(UIColor *)color {
    CGFloat imageW = 3;
    CGFloat imageH = 3;
    // 1.开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"MWDrawColor"]) {
        self.image = [self imageWithColor:self.MWDrawColor];
    }
}


@end
