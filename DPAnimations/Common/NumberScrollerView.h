//
//  NumberScrollerView.h
//  动画集合
//
//  Created by Ray on 15/3/26.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberScrollerView : UIView

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) CFTimeInterval durationOffset;//间隔时间
@property (assign, nonatomic) NSUInteger density;//红球范围
@property (assign, nonatomic) NSUInteger densityBlue;//蓝球范围

@property (assign, nonatomic) NSUInteger minLength;
@property (assign, nonatomic) BOOL isAscending;
@property (assign, nonatomic) NSInteger redNumber;//红球数量
@property (assign, nonatomic) NSInteger blueNumber;//蓝球数量


- (void)startAnimation;
- (void)stopAnimation;
- (void)prepareAnimations ;



@end
