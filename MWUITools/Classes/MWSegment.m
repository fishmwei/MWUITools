//
//  MWSegment.m
//  Pods
//
//  Created by mingwei on 16/10/2.
//
//

#import "MWSegment.h"

@interface MWSegment ()
@property (nonatomic, retain) NSMutableArray *titleLabels;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, weak) UILabel *selectedLabel;
@property (nonatomic, retain) UIView *bottomView;
@property (nonatomic, assign) CGFloat bottomHeight;
 
@end

@implementation MWSegment
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultValues];
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLabels = [NSMutableArray array];
    }
    
    return self;
}

- (void)layoutSubviews {
    NSInteger lastSelectIndex = _selectedIndex;
    [self resetLabels];
    [self setSelectedIndex:lastSelectIndex];
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self resetLabels];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (!self.titleLabels.count) {
        return;
    }
    
    if (selectedIndex >= self.titleLabels.count) {
        selectedIndex = self.titleLabels.count-1;
    }
    
    UILabel *selectLabel = [self.titleLabels objectAtIndex:selectedIndex];
    // 1.标题颜色变成红色,设置高亮状态下的颜色， 以及指示器位置
    [self scrollTitleLabelSelecteded:selectLabel];
    
    if (_autoWith) {
        // 2.让选中的标题居中 (当contentSize 大于self的宽度才会生效)
        [self scrollTitleLabelSelectededCenter:selectLabel];
    }
    // 3.代理方法实现
    _selectedIndex = selectedIndex;
    //    if ([self.segmentDelegate respondsToSelector:@selector(mwSegment:didSelectIndex:)]) {
    //        [self.segmentDelegate mwSegment:self didSelectIndex:index];
    //    }
}

#pragma mark - Private
- (void)setupDefaultValues {
    _selectColor = [UIColor colorWithRed:0x6e/255.0f green:0xb9/255.0f blue:0x2b/255.0f alpha:1.0f];
    _normalColor = [UIColor colorWithRed:0x66/255.0f green:0x66/255.0f blue:0x66/255.0f alpha:1.0f];
    _middleLineColor = [UIColor colorWithRed:0xd6/255.0f green:0xd6/255.0f blue:0xd6/255.0f alpha:1.0f];
    _showMiddleLine = NO;
    _middleLineMargin = 14;
    _selectedIndex = 0;
    _bottomHeight = 3.0f;
    self.bounces = NO;
    _autoWith = NO;
    _labelMargin = 10;
    _titleFont = [UIFont systemFontOfSize:15];
}

- (void)resetLabels {
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bounds)-_bottomHeight, CGRectGetWidth(self.bounds), _bottomHeight)];
    _bottomView.backgroundColor = _selectColor;
    _bottomView.layer.masksToBounds = YES;
    _bottomView.layer.cornerRadius = _bottomHeight/2;
    [self addSubview:_bottomView];
    
    [self.titleLabels removeAllObjects];
    _selectedIndex = 0;
    [self setupLabels];
}

- (void)setupLabels {
    CGFloat offsetX = 0;
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        NSString *title = [_titleArray objectAtIndex:i];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.userInteractionEnabled = YES;
        lab.textColor = _normalColor;
        lab.highlightedTextColor = _selectColor;
        lab.font = self.titleFont;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = title;
        CGFloat labWidth = CGRectGetWidth(self.bounds)/_titleArray.count;
        if (_showMiddleLine) {
            labWidth = (CGRectGetWidth(self.bounds) - _titleArray.count - 1)/_titleArray.count;
        }

        if (_autoWith) {
            labWidth = [self titleSize:title maxSize:CGSizeMake(MAXFLOAT, self.titleFont.pointSize)].width + _labelMargin;
        }
        
        lab.frame = CGRectMake(offsetX, 0, labWidth, CGRectGetHeight(self.bounds)-_bottomHeight);
        offsetX += labWidth;
        [self addSubview:lab];
        [self.titleLabels addObject:lab];
        
        if (_showMiddleLine && i != _titleArray.count-1) {
            CGFloat lineHeight = CGRectGetHeight(self.bounds) - _middleLineMargin;
            if (lineHeight < 0.000001) {
                lineHeight = CGRectGetHeight(self.bounds);
            }
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(offsetX, _middleLineMargin/2.0f, 1,  lineHeight)];
            line.backgroundColor = _middleLineColor;
            line.center = CGPointMake(offsetX, CGRectGetHeight(self.bounds)/2);
            [self addSubview:line];
            
            offsetX += 1;
        }
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTitleClick:)];
        [lab addGestureRecognizer:tap];
    }
    
    [self setContentSize:CGSizeMake(offsetX, 0)];
    [self scrollTitleLabelSelecteded:[_titleLabels firstObject]];
}

- (void)scrollTitleClick:(UITapGestureRecognizer *)tap {
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
    
    // 1.标题颜色变成红色,设置高亮状态下的颜色， 以及指示器位置
    [self scrollTitleLabelSelecteded:selLabel];
    
    if (_autoWith) {
        // 2.让选中的标题居中 (当contentSize 大于self的宽度才会生效)
        [self scrollTitleLabelSelectededCenter:selLabel];
    }
    // 3.代理方法实现
    NSInteger index = [self.titleLabels indexOfObject:selLabel];
    _selectedIndex = index;
    if ([self.segmentDelegate respondsToSelector:@selector(mwSegment:didSelectIndex:)]) {
        [self.segmentDelegate mwSegment:self didSelectIndex:index];
    }
}




/** 滚动标题选中颜色改变以及指示器位置变化 */
- (void)scrollTitleLabelSelecteded:(UILabel *)label {
    
    // 取消高亮
    _selectedLabel.highlighted = NO;
    
    // 颜色恢复
    _selectedLabel.textColor = _normalColor;
    
    // 高亮
    label.highlighted = YES;
    _selectedLabel = label;
    
    
    // 改变指示器位置
    [UIView animateWithDuration:0.20 animations:^{
        CGRect frame = _bottomView.frame;
        frame.size.width = label.frame.size.width;
        frame.origin.x = label.frame.origin.x;
        _bottomView.frame = frame;
    }];
}

/** 滚动标题选中居中 */
- (void)scrollTitleLabelSelectededCenter:(UILabel *)centerLabel {
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - CGRectGetWidth(self.bounds) * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - CGRectGetWidth(self.bounds);
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

-(CGSize)titleSize:(NSString *)title maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : self.titleFont};
    return [title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}




@end
