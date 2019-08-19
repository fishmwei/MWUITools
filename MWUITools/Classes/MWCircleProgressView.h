//
//  MWCircleProgressView.h
//  Pods
//
//  Created by huangmingwei on 16/7/12.
//
//

#import <UIKit/UIKit.h>

@interface MWCircleProgressView : UIView

@property (nonatomic, retain) UIColor *bgColor; //default clearColor
@property (nonatomic, retain) UIColor *strokeColor; // default WhiteColor
@property (nonatomic, assign) CGFloat coverWidth; //default 5

- (void)updateProgress:(CGFloat)progress;

@end
