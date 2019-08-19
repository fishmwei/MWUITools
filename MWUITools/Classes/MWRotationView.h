//
//  MWRotationView.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/28.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWRotationView : UIView

@property (nonatomic, readonly, getter=isStop) BOOL stop;
@property (nonatomic, getter=isClockWise) BOOL clockWise; //default YES
@property (nonatomic, assign) CFTimeInterval duration; //the time of a full animation, Uinit : sec, default 5s


- (void)start;
- (void)stop;
@end
