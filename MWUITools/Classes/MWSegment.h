//
//  MWSegment.h
//  Pods
//
//  Created by mingwei on 16/10/2.
//
//

#import <UIKit/UIKit.h>

@class MWSegment;

@protocol MWSegmentDelegate <NSObject>

- (void)mwSegment:(MWSegment *)segment didSelectIndex:(NSUInteger)index;

@end

@interface MWSegment : UIScrollView

@property (nonatomic, retain) UIColor *selectColor;
@property (nonatomic, retain) UIColor *normalColor;
@property (nonatomic, retain) UIColor *middleLineColor;
@property (nonatomic, assign) BOOL showMiddleLine; //deafult NO
@property (nonatomic, assign) CGFloat middleLineMargin; // default 14

@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, assign) BOOL autoWith; //default NO
@property (nonatomic, assign) NSInteger labelMargin; // worked when autoWidth is YES
@property (nonatomic, retain) UIFont *titleFont; 
@property (nonatomic, weak) id <MWSegmentDelegate> segmentDelegate;

//called after titleArray is set.
- (void)setSelectedIndex:(NSInteger)selectedIndex;

@end
